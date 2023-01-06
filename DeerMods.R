mTime2<-bam(formula = DEER*.25 ~ te(X_coord, Y_coord, Day, 
                                   k = c(30,30), bs = c("cr", "cc"), 
                                   d = c(2, 1)) + 
             s(CAMFact, bs = "re") + 
             s(AR1DEERSC, k=15, bs='cr') + 
             TrailFact * CombWolfPAFact + 
             TrailFact * ZWolfTrue + 
             TrailFact * CombCoyFact + 
             TrailFact * wolfrange + 
             #s(ResEVIsc, k = 15, bs = "cr") + 
             #+s(IntEVIsc, k = 15, bs = "cr") + 
             DailySnowSC * CombWolfPAFact +
             DailySnowSC * ZWolfTrue + 
             DailySnowSC * CombCoyFact + 
             DailySnowSC * wolfrange +
             Wooded250sc * CombWolfPAFact + 
             Wooded250sc * ZWolfTrue + 
             Wooded250sc * CombCoyFact + 
             Wooded250sc * wolfrange + 
             DailyEVISC * CombWolfPAFact + 
             DailyEVISC * ZWolfTrue + 
             DailyEVISC * CombCoyFact+
             DailyEVISC * wolfrange+
              IntEVIsc * CombWolfPAFact + 
              IntEVIsc * ZWolfTrue + 
              IntEVIsc * CombCoyFact+
              IntEVIsc * wolfrange,
           family = tw(theta = NULL, link = "log", a = 1.01, b = 1.99), 
           data = BehavsFrame_Cent_occu2, discrete = TRUE)



mForage2<-bam(formula = cbind(forage, npics) ~ te(X_coord, Y_coord, Day, 
                                                 k = c(30,30), bs = c("tp", "cc"), 
                                                 d = c(2, 1)) + 
               s(CAMFact, bs = "re") + 
               TrailFact * CombWolfPAFact + 
               TrailFact * ZWolfTrue + 
               TrailFact * CombCoyFact + 
               TrailFact * wolfrange + 
               DailySnowSC * CombWolfPAFact +
               DailySnowSC * ZWolfTrue + 
               DailySnowSC * CombCoyFact + 
               DailySnowSC * wolfrange +
               Wooded250sc * CombWolfPAFact + 
               Wooded250sc * ZWolfTrue + 
               Wooded250sc * CombCoyFact + 
               Wooded250sc * wolfrange + 
               DailyEVISC * CombWolfPAFact + 
               DailyEVISC * ZWolfTrue + 
               DailyEVISC * CombCoyFact+
               DailyEVISC * wolfrange+
               IntEVIsc * CombWolfPAFact + 
               IntEVIsc * ZWolfTrue + 
               IntEVIsc * CombCoyFact+
               IntEVIsc * wolfrange,
             family = quasibinomial, 
             data = BehavsFrame_Cent_occu2, discrete = TRUE)


mVig2<-bam(formula = cbind(vigilant, npics) ~ te(X_coord, Y_coord, Day, 
                                                k = c(30,30), bs = c("tp", "cc"), 
                                                d = c(2, 1)) + 
            s(CAMFact, bs = "re") + 
            TrailFact * CombWolfPAFact + 
            TrailFact * ZWolfTrue + 
            TrailFact * CombCoyFact + 
            TrailFact * wolfrange + 
            #s(ResEVIsc, k = 15, bs = "cr") + 
            #s(IntEVIsc, k = 15, bs = "cr") + 
            DailySnowSC * CombWolfPAFact +
            DailySnowSC * ZWolfTrue + 
            DailySnowSC * CombCoyFact + 
            DailySnowSC * wolfrange +
            Wooded250sc * CombWolfPAFact + 
            Wooded250sc * ZWolfTrue + 
            Wooded250sc * CombCoyFact + 
            Wooded250sc * wolfrange + 
            DailyEVISC * CombWolfPAFact + 
            DailyEVISC * ZWolfTrue + 
            DailyEVISC * CombCoyFact+
            DailyEVISC * wolfrange+
             IntEVIsc * CombWolfPAFact + 
             IntEVIsc * ZWolfTrue + 
             IntEVIsc * CombCoyFact+
             IntEVIsc * wolfrange, 
          family = quasibinomial, 
          data = BehavsFrame_Cent_occu2, discrete = TRUE)
