matern_cov <- function(d, nu, ell) {
  if (nu == 0.5) {
    matern_cov=exp(-sqrt((sin(2*pi*d/p))^2) / ell)
    
  } else {
    factor1 <- (2^(1 - nu)) / gamma(nu)
    factor2 <- ((sqrt(2 * nu) * 2*sqrt((sin(pi*d/p))^2)) / ell)^nu
    besselk_val <- besselK((sqrt(2 * nu) * 2*sqrt((sin(pi*d/p))^2)) / ell, nu)
    matern_cov=factor1 * factor2 * besselk_val}
  return(matern_cov)
}
