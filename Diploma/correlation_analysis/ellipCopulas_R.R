library(copula)

fit_copulas <- function(data) {
  library(copula)
  u <- cor(data)
  
  gc = ellipCopula(family="normal", param=P2p(u), dim=ncol(u), dispstr="un")
  sim_gc = rCopula(1000, gc)
  
  tc = ellipCopula(family="t", param=P2p(u), dim=ncol(u), dispstr="un")
  sim_tc = rCopula(1000, tc)
  
  fit_gc = fitCopula(copula=gc, data=sim_gc, method="mpl")
  fit_tc = firCopula(copula=tc, data=sim_tc, method="mpl") 
  
  list(
    gaussian_ll = fit_gc@loglik,
    gaussian_corr = p2P(coef(fit_gc)), 
    student_ll = fit_tc@loglik,
    student_corr = p2P(coef(fit_tc))
  )
}