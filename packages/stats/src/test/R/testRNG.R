
# Test for consistency of renjin generated pseudo random numbers.

library(hamcrest)

DELTA <- 0.01

test.RNGkind <- function() {
	k <- RNGkind('Mersenne-Twister', 'Inversion')
	assertThat(k, equalTo(c("Mersenne-Twister", "Inversion")))
}

test.runif <- function() {
	set.seed(12345, 'Mersenne-Twister','I')
	assertThat(runif(1,0,2), closeTo(1.441808, 0.01))
	assertThat(mean(runif(100000,0,2)), closeTo(1.001036, 0.01))
}


test.rbinom <- function() {
	set.seed(12345, 'Mersenne-Twister','I')
	assertThat(mean(rbinom(1000,100,0.5)), closeTo(50.078, DELTA))
	assertThat(mean(rbinom(1000,200,0.9)), closeTo(180.132, DELTA))
	assertThat(mean(rbinom(1000,250,0.12)), closeTo(30.339, DELTA))
}

test.rsignrank <- function() {
	set.seed(12345, 'Mersenne-Twister','I')
	assertThat(mean(rsignrank(1000,10)), closeTo(27.616, DELTA))
}

test.rwilcox <- function() {
	set.seed(12345, 'Mersenne-Twister','I')
	assertThat(mean(rwilcox(10000,4,5)), closeTo(9.9969, DELTA))
}


test.rhyper <- function() {
	set.seed(12345, 'Mersenne-Twister','I')
	assertThat(mean(rhyper(10000,17,16,13)), closeTo(6.3045, DELTA))
}


test.rnorm <- function() {
	set.seed(12345, 'Mersenne-Twister','I')
	assertThat(mean(rnorm(10000,0,1)), closeTo(-0.0006897654, DELTA))
}


test.rgamma <- function() {
	set.seed(12345, 'Mersenne-Twister','I')
	assertThat(rgamma(1,2,3), closeTo(0.7676115, DELTA))
}


test.rchisq <- function() {
	set.seed(12345, 'Mersenne-Twister','I')
	assertThat(rchisq(1,6), closeTo(7.023027, DELTA))
}


test.rexp <- function() {
	set.seed(12345, 'Mersenne-Twister','I')
	assertThat(rexp(1,6), closeTo(0.07363463, DELTA))
}


test.rcauchy <- function() {
	set.seed(1235, 'Mersenne-Twister','I')
	assertThat(rcauchy(1,8,6), closeTo(13.727041, DELTA))
}


test.rlogis <- function() {
	set.seed(12345, 'Mersenne-Twister','I')
	assertThat(rlogis(1,3,4), closeTo(6.795799, DELTA))
}


test.rweibull <- function() {
	set.seed(12345, 'Mersenne-Twister','I')
	assertThat(rweibull(1,4,3), closeTo(2.269034, DELTA))
}



test.rf <- function() {
	set.seed(12345, 'Mersenne-Twister','I')
	assertThat(rf(1,5,7), closeTo(1.0, DELTA))
}


test.rbeta <- function() {
	set.seed(12345, 'Mersenne-Twister','I')
	assertThat(rbeta(1,8,6), closeTo(0.4811752, 0.1))
}


test.rpois <- function() {
	set.seed(12345, 'Mersenne-Twister','I')
	assertThat(rgamma(1,8), closeTo(9.189248, 0.1))
}


test.rgeom <- function() {
	set.seed(12345, 'Mersenne-Twister','I')
	assertThat(rgeom(1,0.5), closeTo(1.0, 0.1))
}


test.rt <- function() {
	set.seed(12345, 'Mersenne-Twister','I')
	assertThat(rt(1,3), closeTo(0.5293467, 0.1));
}

test.rmultinom <- function() {
	set.seed(1234, 'Mersenne-Twister','I')
	assertThat(rmultinom(1,3,c(0.5,0.5)), equalTo(structure(c(0,3), .Dim = 2:1)))
	assertThat(dim(rmultinom(20,3,c(0.5,0.3,0.2))), equalTo(c(3,20)))
}

test.randomSeedSetInGlobalEnv <- function() {
	.GlobalEnv$x <- 42
	runif(1)
	print(.GlobalEnv)
	print(ls(envir=.GlobalEnv,all.names=T))
	get('.Random.seed', envir = .GlobalEnv, inherits = FALSE)
}