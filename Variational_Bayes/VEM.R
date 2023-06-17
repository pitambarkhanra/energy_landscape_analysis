### Subfunctions

vech <- function(M)
{
  d <- ncol(M)
  v <- NULL
  for ( k in 1:(d-1) ) {
    v <- c(v, M[k, (k+1):d])
  }
  
  return(v)
}

ivech <- function(v, d)
{
  M <- matrix(0, d, d)
  lb <- 1
  ub <- d - 1
  for ( k in 1:(d-1) ) {
    M[k, (k+1):d] <- v[lb:ub]
    lb <- ub + 1
    ub <- ub + (d - k - 1)
  }
  
  return(M)
}

Make.tilde <- function(x)
{
  x <- as.matrix(x)
  n <- nrow(x)
  d <- ncol(x)
  
  xx <- matrix(NA, n, d*(d-1)/2)
  k <- 0
  for ( i in 1:(d-1) ) {
    for ( j in (i+1):d ) {
      k <- k + 1
      xx[,k] <- x[,i]*x[,j]
    }
  } 
  x.tilde <- cbind(x, xx)
  
  return(x.tilde)
}

energy <- function(x, h, J)
{
  x.tilde <- Make.tilde(x)
  theta <- c(h, vech(J))
  energy <- -pmin(drop(x.tilde %*% theta), 5.0e6)
  
  return(energy)
}

MakeS <- function(d)
{
  S <- matrix(NA, 2^d, d)
  for ( k in 1:d ) {
    S[,k] <- rep(rep(c(0, 1), each = 2^(d-k)), 2^(k-1))
  }
  return(S)
}


### Boltzmann distribution
  
dBoltzmann <- function(x, h, J)
{
  x <- as.matrix(x)
  n <- nrow(x)
  d <- ncol(x)
  S <- MakeS(d)
  Z <- sum(exp(-energy(S, h, J)))
  ans <- exp(-energy(x, h, J))/max(Z, 1.0e-8)
  
  return(ans)
}

Model.meanv <- function(h, J)
{
  d <- length(h)
  S <- MakeS(d)
  S.tilde <- Make.tilde(S)
  P <- matrix(dBoltzmann(S, h, J), 
              nrow = 2^d, ncol = d*(d+1)/2, 
              byrow = FALSE)
  ans <- colSums(S.tilde*P)
  
  return(ans)
}

Model.covM <- function(h, J)
{
  d <- length(h)
  S <- MakeS(d)
  S.tilde <- Make.tilde(S)
  p <- dBoltzmann(S, h, J)
  N <- nrow(S)  
  m <- Model.meanv(h, J)
  
  ans <- matrix(0, ncol(S.tilde), ncol(S.tilde))
  for ( n in 1:N ) {
    s <- S.tilde[n,]
    ans <- ans + p[n]*(s %*% t(s))
  }
  ans <- ans - m %*% t(m)
  
  return(ans)
}


### R functions for VEM
  
ELBO.Boltzmann <- function(x, N, subj, eta, alpha, mu, beta)
{
  # x: T * d matrix (T = T_1 + ... + T_N), data
  # N: number of subjects
  # subj: T-vector = c(rep(1, T_1), ..., c(N, T_N))
  # eta: d(d+1)/2 vector, prior mean
  # alpha: d(d+1)/2 vector, prior precision
  # mu: N * d(d+1)/2 matrix, composed of posterior mean vectors
  # beta: N * d(d+1)/2 matrix, composed of posterior precision vectors
  
  d <- ncol(x)
  S <- MakeS(d)
  S.tilde <- Make.tilde(S)
  
  term1 <- 0
  term2 <- N*sum(log(alpha))
  for (n in 1:N) {
    x.n <- x[subj == n,]
    if (sum(is.na(x.n)) == 0) {
      Tn <- nrow(x.n)
      h0 <- eta[1:d]
      J0 <- ivech(eta[-(1:d)], d)
      m.eta <- Model.meanv(h0, J0)
      C.eta <- Model.covM(h0, J0)
      
      tmp <- mu[n,] - eta
      term1 <- term1 + sum(mu[n,]*colSums(Make.tilde(x.n))) 
      term1 <- term1 - Tn*log(sum(exp(S.tilde%*%eta)))
      term1 <- term1 - Tn*sum(m.eta*tmp) 
      term1 <- term1 - 0.5*Tn*drop(t(tmp) %*% C.eta %*% tmp)
      term1 <- term1 - 0.5*Tn*sum(diag(C.eta)/beta[n,])
      
      term2 <- term2 - drop(t(tmp) %*% diag(alpha) %*% tmp)
      term2 <- term2 - sum(alpha/beta[n,])
    }
  }
  term2 <- 0.5 * term2
  term3 <- -0.5 * sum(log(beta), na.rm = TRUE)
  
  ans <- term1 + term2 + term3
  
  return(ans)
}

VEM.Boltzmann <- function(x, N, subj, tol = 5e-8, max.iter = 4000, doplot = TRUE, dotrace = TRUE)
{
  # x: stacked data set
  # N: number of subjects in x
  # subj: index (1, 1, 1, ..., 1, 2, 2, ...., 2, ...., ..., N, N, ...,N)
  #              ---------------  -------------             -----------
  
  d <- ncol(x)  # Number of ROIs
  D <- d * (d + 1) / 2  # number of model parameters
  S <- MakeS(d)  # all possible states
  S.tilde <- Make.tilde(S) 
  
  # Initialization
  eta <- rnorm(D, sd = 0.1)
  alpha.h <- 6
  alpha.J <- 30
  alpha <- c(rep(alpha.h, d), rep(alpha.J, D - d))
  mu <- matrix(NA, N, D, byrow = TRUE)  # posterior means
  beta <- matrix(NA, nrow = N, ncol = D, byrow = TRUE)   # posterior precisions
  ELBO <- rep(NA, max.iter)
  
  # Iterative algorithm
  iter <- converged <- 0
  while(iter < max.iter) {
    
    iter <- iter + 1
    if(dotrace) cat("[Iteration ", iter, "]", sep = "")
    
    ###################################################
    # posterior mean and precision vector calculation #
    ###################################################
    
    h0 <- eta[1:d]
    J0 <- ivech(eta[-(1:d)], d)
    m.eta <- Model.meanv(h0, J0)
    C.eta <- Model.covM(h0, J0)
    for ( n in 1:N ) {
      x.n <- x[subj == n,]
      if (sum(is.na(x.n)) > 0) {  # ignore this block
        mu[n,] <- beta[n,] <- rep(NA, D)
      } else {
        Tn <- nrow(x.n)
        tmp <- Tn*(colMeans(Make.tilde(x.n), na.rm = TRUE) - m.eta)
        mu[n,] <- eta + drop(solve(Tn*C.eta + diag(alpha)) %*% tmp)
        beta[n,] <- alpha + Tn * diag(C.eta)
      }
    }
    
    #######################################################
    # updating the prior mean vector and precision vector #
    #######################################################
    eta <- colMeans(mu, na.rm = TRUE)
    Eta <- matrix(eta, nrow = N, ncol = D, byrow = TRUE)
    A <- (mu - Eta)^2 + 1/beta
    alpha <- 1/colMeans(A, na.rm = TRUE)
    alpha.h <- 1/mean(rowMeans(A[,1:d]), na.rm = TRUE)
    #alpha.h <- 1/mean(A[,1:d], na.rm = TRUE)
    alpha.J <- 1/mean(rowMeans(A[,-(1:d)]), na.rm = TRUE)
    #alpha.J <- 1/mean(A[,-(1:d)], na.rm = TRUE)
    alpha <- c(rep(alpha.h, d), rep(alpha.J, D - d))
    
    
    ############################
    # Checking the convergence #
    ############################
    ELBO[iter] <- ELBO.Boltzmann(x, N, subj, eta, alpha, mu, beta)
    if(dotrace) cat(" ELBO = ", ELBO[iter], "\n", sep = "")
    if(iter > 3) {
      if(abs(ELBO[iter]/ELBO[iter - 1] - 1) < tol) {
        converged <- 1
        if(dotrace) cat("Converged!!\n")
        break
      }
    }
  }
  
  ELBO <- ELBO[!is.na(ELBO)]
  if(doplot) plot(ELBO,
                  col = "navy", type = "b", pch = 19, 
                  xlab = "Iteration", ylab = "ELBO")
  if(converged == 0 & dotrace) cat("Warning: Not converged!!\n")
  
  return(list(eta = eta, alpha = alpha, # prior 
              mu = mu, beta = beta,     # posterior
              ELBO = ELBO, iter = iter, converged = converged))
}


