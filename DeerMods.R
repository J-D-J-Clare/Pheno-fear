mTime2<-bam(formula = DEERTime~ te(X_coord, Y_coord, Day, 
                                   k = c(30,30), bs = c("cr", "cc"), 
                                   d = c(2, 1)) + 
             s(CAMFact, bs = "re") + 
             s(AR1DEERSC, k=15, bs='cr') + 
             TrailFact * WolfDet + 
             TrailFact * WolfOcc + 
             TrailFact * CoyDet + 
             TrailFact * wolfrange + 
             DailySnowSC * WolfDet +
             DailySnowSC * WolfOcc + 
             DailySnowSC * CoyDet + 
             DailySnowSC * wolfrange +
             Wooded250sc * WolfDet + 
             Wooded250sc * WolfOcc + 
             Wooded250sc * CoyDet + 
             Wooded250sc * wolfrange + 
             DailyEVISC * WolfDet + 
             DailyEVISC * WolfOcc + 
             DailyEVISC * CoyDet+
             DailyEVISC * wolfrange+
              IntEVIsc * WolfDet + 
              IntEVIsc * WolfOcc + 
              IntEVIsc * CoyDet+
              IntEVIsc * wolfrange,
           family = tw(theta = NULL, link = "log", a = 1.01, b = 1.99), 
           data = Behavs_Deer_Data, discrete = TRUE)



mForage2<-bam(formula = cbind(forage, npics) ~ te(X_coord, Y_coord, Day, 
                                                 k = c(30,30), bs = c("tp", "cc"), 
                                                 d = c(2, 1)) + 
               s(CAMFact, bs = "re") + 
               TrailFact * WolfDet + 
               TrailFact * WolfOcc + 
               TrailFact * CoyDet + 
               TrailFact * wolfrange + 
               DailySnowSC * WolfDet +
               DailySnowSC * WolfOcc + 
               DailySnowSC * CoyDet + 
               DailySnowSC * wolfrange +
               Wooded250sc * WolfDet + 
               Wooded250sc * WolfOcc + 
               Wooded250sc * CoyDet + 
               Wooded250sc * wolfrange + 
               DailyEVISC * WolfDet + 
               DailyEVISC * WolfOcc + 
               DailyEVISC * CoyDet+
               DailyEVISC * wolfrange+
               IntEVIsc * WolfDet + 
               IntEVIsc * WolfOcc + 
               IntEVIsc * CoyDet+
               IntEVIsc * wolfrange,
             family = quasibinomial, 
             data = Behavs_Deer_Data, discrete = TRUE)


mVig2<-bam(formula = cbind(vigilant, npics) ~ te(X_coord, Y_coord, Day, 
                                                k = c(30,30), bs = c("tp", "cc"), 
                                                d = c(2, 1)) + 
            s(CAMFact, bs = "re") + 
            TrailFact * WolfDet + 
            TrailFact * WolfOcc + 
            TrailFact * CoyDet + 
            TrailFact * wolfrange + 
            DailySnowSC * WolfDet +
            DailySnowSC * WolfOcc + 
            DailySnowSC * CoyDet + 
            DailySnowSC * wolfrange +
            Wooded250sc * WolfDet + 
            Wooded250sc * WolfOcc + 
            Wooded250sc * CoyDet + 
            Wooded250sc * wolfrange + 
            DailyEVISC * WolfDet + 
            DailyEVISC * WolfOcc + 
            DailyEVISC * CoyDet+
            DailyEVISC * wolfrange+
             IntEVIsc * WolfDet + 
             IntEVIsc * WolfOcc + 
             IntEVIsc * CoyDet+
             IntEVIsc * wolfrange, 
          family = quasibinomial, 
          data = Behavs_Deer_Data, discrete = TRUE)
