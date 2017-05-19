
DATASET ACTIVATE DataSet0.
GLM hungry_r_p hungry_r_i hungry_s_p hungry_s_i hurts_r_p hurts_r_i hurts_s_p hurts_s_i no_r_p 
    no_r_i no_s_p no_s_i yes_r_p yes_r_i yes_s_p yes_s_i
  /WSFACTOR=stim 4 Polynomial R_S 2 Polynomial P_I 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(stim) 
  /EMMEANS=TABLES(R_S) 
  /EMMEANS=TABLES(P_I) 
  /EMMEANS=TABLES(stim*R_S) 
  /EMMEANS=TABLES(stim*P_I) 
  /EMMEANS=TABLES(R_S*P_I) 
  /EMMEANS=TABLES(stim*R_S*P_I) 
  /PRINT=DESCRIPTIVE 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=stim R_S P_I stim*R_S stim*P_I R_S*P_I stim*R_S*P_I.
