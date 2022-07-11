 // coyote occupancy models...
      
      data {
      int<lower=1> nsites;  
      int<lower=1> nt;  
      int<lower=1> nobs;                
      int<lower=1> nbasis_s;
      int<lower=1> nbasis_t;
      int<lower=0, upper=1> y[nobs];
      vector[nobs] combdeer;
      vector[nobs] arcoy;
      vector[nobs] DailyEVI;
      vector[nobs] ResEVI;
      vector[nobs] DailySnow;
      vector[nobs] DaySC;
      vector[nobs] DaySCsq;
      vector[nsites] Forest5km;             
      vector[nsites] Forest;             
      vector[nsites] Richness;          
      vector[nsites] Trail;            
      int<lower=0, upper=1> ymax[nsites];
      int from[nsites];
      int to[nsites];
      int length[nsites];
      int Day[nobs];
      int CamNum[nobs];
      vector[nsites] IntEVI;  
      }
      
      
      parameters {
      real a0_psi;
      real a1_psi;
      real a2_psi;
      vector[nsites] eps_p_raw;
      real<lower=0> var_p_eps;
      
      real b0_p;
      real b1_p;
      real b2_p;
      real b3_p;
      real b4_p;
      real b5_p;
      real b6_p;
      real b7_p;
      real b8_p;
      real b9_p;
      real b10_p; 
      real b11_p; 
      real b12_p; 
      real b13_p; 
      real b14_p; 
      }
      
      transformed parameters {
      vector[nsites] psi;        
      vector[nobs] p;
      vector[nsites] eps_p;
      eps_p=eps_p_raw*var_p_eps;
      for (i in 1:nsites) {
        psi[i]=inv_logit(a0_psi+a1_psi*IntEVI[i]+a2_psi*Forest5km[i]);
      }    
      
      for (o in 1:nobs){
      p[o] = inv_logit(b0_p+
      b1_p*Forest[CamNum[o]]+
      b2_p*Trail[CamNum[o]]+b3_p*arcoy[o]+b4_p*IntEVI[CamNum[o]]+
      b5_p*DailySnow[o]+
      b6_p*DailyEVI[o]+b7_p*ResEVI[o]+
      b8_p*DaySC[o]+b9_p*DaySCsq[o]+
      b10_p*combdeer[o]+
      b11_p*combdeer[o]*Trail[CamNum[o]]+
      b12_p*combdeer[o]*DailySnow[o]+
      b13_p*combdeer[o]*Forest[CamNum[o]]+
      b14_p*combdeer[o]*DailyEVI[o]+
      eps_p[CamNum[o]]);
      
      }
      
      
      }
      
      model {
      a0_psi~normal(0, 1.4);
      a1_psi~normal(0, 1.4);
      a2_psi~normal(0, 1.4);
      var_p_eps~normal (0, 1);
      
      b0_p ~ normal (0, 1.4);  
      b1_p ~ normal (0, 1.4);  
      b2_p ~ normal (0, 1.4);  
      b3_p ~ normal (0, 1.4);  
      b4_p ~ normal (0, 1.4);  
      b5_p ~ normal (0, 1.4);  
      b6_p ~ normal (0, 1.4);  
      b7_p ~ normal (0, 1.4);  
      b8_p ~ normal (0, 1.4);  
      b9_p ~ normal (0, 1.4);  
      b10_p ~ normal (0, 1.4); 
      b11_p ~ normal (0, 1.4);  
      b12_p ~ normal (0, 1.4);  
      b13_p ~ normal (0, 1.4);  
      b14_p ~ normal (0, 1.4);
      
      
      eps_p_raw~std_normal();
      
     
      for (i in 1:nsites) {
            if (ymax[i] > 0) {
                target+=bernoulli_lpmf(1|psi[i])+bernoulli_lpmf(y[from[i]:to[i]]|p[from[i]:to[i]]);
        }else{
            target+=log_sum_exp(bernoulli_lpmf(1|psi[i])+bernoulli_lpmf(y[from[i]:to[i]]|p[from[i]:to[i]]),
              bernoulli_lpmf(0|psi[i]));
      
          }
        }
      }
     
      
      generated quantities {
      real psi_con[nsites];  // prob present | data 
      for (i in 1:nsites) {
      if (ymax[i] == 0) {  // species not detected
      vector[length[i]] q = 1-(p[from[i]:to[i]]);  // q = 1 - p
      real qT = prod(q[]);
      psi_con[i] = (psi[i] * qT) / (psi[i] * qT + (1 - psi[i]));
      
      } else {             // species detected at least once
      psi_con[i] = 1;
      }
      }
      
      }