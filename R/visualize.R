#' visualize integration area
#'
#' Visualize 2D/3D integration area with random experienments
#'
#' @param bounds:necessary, the bounds of x, y, z, as a vector of 2, 4 or 6 dimensions
#' @param constrains: optional, inequalities that x, y, z must satisfy, input as character, must contains x, y, or z, default: 1
#' @examples
#' visualize_area(c(-2,2, -2,2, -1,1), c("x^2/4+y^2/4+z^2/1<1", "x<y^2"))
#'
#' @export
visualize_area <- function(bounds, constrains)
{
    if(missing(constrains)){constrains<-TRUE}
    dim <- check_dim(bounds)
    constrains <- check_constrains(constrains)

    area <- calculate_area(bounds)

    n = 500*area
    rands <- sampling(bounds, n)
    x <- rands[1,]
    if (dim>1){y <- rands[2,]}
    if (dim>2){z <- rands[3,]}

    # eval constrains
    c_num <- length(constrains)
    constrains_eval = rep(1, n)
    for (i in 1:c_num){
        constrains_eval = constrains_eval*eval(parse(text=constrains[i]))
    }

    if (dim==2){
        p <- plotly::plot_ly(x=x,y=y,color=constrains_eval,marker=list(opacity=0.2,size=2),colors=c("#0083FF","#FF0000"))
        p <- plotly::add_markers(p)
    }
    else if (dim==3){
        p <- plotly::plot_ly(x=x,y=y,z=z,color=constrains_eval,marker=list(opacity=0.2,size=2),colors=c("#0083FF","#FF0000"))
        p <- plotly::add_markers(p)
    }
    else {stop("only 2D/3D supported.")}
    return(p)
}
