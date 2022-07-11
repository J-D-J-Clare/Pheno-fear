// wolf occupancy models...
      
      data {
      int<lower=1> nsites;  
      int<lower=1> nt;  
      int<lower=1> nobs;                
      int<lower=1> nbasis_s;
      int<lower=0, upper=1> y[nobs];
      vector[nobs] combdeer;
      vector[nobs] arwolf;
      vector[nobs] DailyEVI;
      vector[nobs] ResEVI;
      vector[nobs] DailySnow;
      vector[nsites] Forest5km;             
      vector[nsites] Forest;             
      vector[nsites] Trail;
      vector[nsites] IntEVI;
      matrix[nsites, nbasis_s] B_space;
      int<lower=0, upper=1> ymax[nsites];
      int from[nsites];
      int to[nsites];
      int length[nsites];
      int Day[nobs];
      int CamNum[nobs];
      }
      
      
      parameters {
      real a0_psi;
      real a1_psi;
      real a2_psi;
      row_vector[nbasis_s] s_psi;
      real<lower=0> sd_psi;
  
      
      real b0_p;
      real b1_p;
      real b2_p;
      real b3_p;
      real b4_p;
      real b5_p;
      real b6_p;
      real b7_p;
      }
      
      transformed parameters {
      vector[nsites] psi;                 
      vector[nobs] p;
     

      
      for (i in 1:nsites) {
      psi[i]=inv_logit(a0_psi+dot_product(s_psi, B_space[i,])+a1_psi*Forest5km[i]+a2_psi*IntEVI[i]);
      }      
      
      for (o in 1:nobs){
      p[o] = inv_logit(b0_p+
      b1_p*Trail[CamNum[o]]+b2_p*arwolf[o]+
      b3_p*IntEVI[CamNum[o]]+
      b4_p*Forest[CamNum[o]]+b5_p*combdeer[o]+
      b6_p*DailySnow[o]+b7_p*DailyEVI[o]); 
      }
      
      
      }
      
      model {
      a0_psi ~ normal (0, 1.4);
      a1_psi ~ normal (0, 1.4);
      a2_psi ~ normal (0, 1.4);
      
      b0_p ~ normal (0, 1.4);
      b1_p ~ normal (0, 1.4);
      b2_p ~ normal (0, 1.4);
      b3_p ~ normal (0, 1.4);
      b4_p ~ normal (0, 1.4);
      b5_p ~ normal (0, 1.4);
      b6_p ~ normal (0, 1.4);
      b7_p ~ normal (0, 1.4);
      
      
      s_psi ~ normal(0, sd_psi);
      sd_psi ~ normal(0, 1);
     
       //likelihood
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
      
      
