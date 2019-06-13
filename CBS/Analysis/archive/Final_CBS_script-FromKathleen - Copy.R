#'Al's exp 1 exercise study - beh data - final script
#'
#'
#'
#'Load Data
ex_data = read.csv('/Users/alexandra/Dropbox/CBS_exercise/CBS Data/Exp1/sleep_exercise_clean.csv')

#ex_data = read.csv('/Users/klyons/Dropbox/R-Expt1/sleep_exercise_clean.csv')
#ex_data = read.csv('/Users/kathleen/Documents/Dropbox/R-Expt1/sleep_exercise_clean.csv')
#Load required packages - if running on new computer uncomment the install packages code

#install.packages('tidyverse')
library(tidyverse)
#install.packages('ggplot2')
library(ggplot2)
#install.packages('lme4')
library('lme4')
#install.packages('effsize')
library(effsize)
#install.packages('BayesFactor')
library(BayesFactor)


#demo
#summary of important aspects of data
summary(ex_data$gender)
summary(ex_data$age_at_test)
summary(ex_data$education)
summary(ex_data$exercise_frequency)
ex_data1 = subset(ex_data, hours_slept < 24)
Age_Ex = ex_data1 %>% group_by(exercise_frequency) %>% summarise(mean = mean(age_at_test), SD = sd(age_at_test), min = min(age_at_test), max = max(age_at_test), n = n())
Sleep_hours_Ex = ex_data1 %>% group_by(exercise_frequency) %>% summarise(mean = mean(hours_slept), SD = sd(hours_slept), min = min(hours_slept), max = max(hours_slept), n = n())
table(ex_data1$exercise_frequency, ex_data1$sleep_quality)
summary(ex_data1$age_at_test)

#AGE IS SIGNIFICANTLY DIFFERENT
anova(lm(data=ex_data1, age_at_test ~ exercise_frequency))

ex_data1$exercise_frequency_order <- factor(ex_data1$exercise_frequency, levels = c('Not during the past month', 'Less than once a week', 'Once or twice a week','Three or more times a week', 'Every day'))

#AGE x EXERCISE INTERACTION MODELS
ex_only_verbal = lm(data= ex_data1, day_1_verbal ~ exercise_frequency_order)
ex_only_reasoning = lm(data= ex_data1, day_1_reasoning ~ exercise_frequency_order)
extimesage_memory = lm(data= ex_data1, day_1_memory ~ exercise_frequency_order*age_at_test)
summary(extimesage_memory)
summary(ex_only_memory)
extimesage_verbal = lm(data= ex_data1, day_1_verbal ~ exercise_frequency_order*age_at_test)
summary(ex_only_verbal)
summary(extimesage_verbal)
extimesage_reasoning = lm(data= ex_data1, day_1_reasoning ~ exercise_frequency_order*age_at_test)
summary(ex_only_reasoning)
summary(extimesage_reasoning)


###step wise regression for all tests and domains

summary(lm(data=ex_data1, day_1_memory ~ age_at_test))
ex_only_memory = lm(data= ex_data1, day_1_memory ~ exercise_frequency_order)
summary(ex_only_memory)
null_mem = lm(data= ex_data1, day_1_memory ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education)
full_mem = lm(data= ex_data1, day_1_memory ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education + exercise_frequency_order)
summary(full_mem)
anova(null_mem, full_mem)



summary(lm(data=ex_data1, day_1_verbal ~ age_at_test))
ex_only_verbal = lm(data= ex_data1, day_1_verbal ~ exercise_frequency_order)
summary(ex_only_verbal)
null_ver = lm(data= ex_data1, day_1_verbal ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education)
full_ver = lm(data= ex_data1, day_1_verbal ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education + exercise_frequency_order)
summary(full_ver)
anova(null_ver, full_ver)

summary(lm(data=ex_data1, day_1_reasoning ~ age_at_test))
ex_only_reasoning = lm(data= ex_data1, day_1_reasoning ~ exercise_frequency_order)
summary(ex_only_reasoning)
null_reas = lm(data= ex_data1, day_1_reasoning ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education)
full_reas = lm(data= ex_data1, day_1_reasoning ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education + exercise_frequency_order)
summary(full_reas)
anova(null_reas, full_reas)



summary(lm(data=ex_data1, day_1_double_trouble ~ age_at_test))
ex_only_DT = lm(data= ex_data1, day_1_double_trouble ~ exercise_frequency_order)
null_DT = lm(data= ex_data1, day_1_double_trouble ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education)
full_DT = lm(data= ex_data1, day_1_double_trouble ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education + exercise_frequency_order)
summary(full_DT)
anova(null_DT, full_DT)


summary(lm(data=ex_data1, day_1_digit_span ~ age_at_test))
ex_only_DS = lm(data= ex_data1, day_1_digit_span ~ exercise_frequency_order)
null_DS = lm(data= ex_data1, day_1_digit_span ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education)
full_DS = lm(data= ex_data1, day_1_digit_span ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education + exercise_frequency_order)
summary(full_DS)
anova(null_DS, full_DS)



ex_only_OOO = lm(data= ex_data1, day_1_odd_one_out ~ exercise_frequency_order)
null_OOO = lm(data= ex_data1, day_1_odd_one_out ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education)
full_OOO = lm(data= ex_data1, day_1_odd_one_out ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education + exercise_frequency_order)
summary(full_OOO)
anova(null_OOO, full_OOO)


ex_only_ST = lm(data= ex_data1, day_1_spatial_tree ~ exercise_frequency_order)
null_ST = lm(data= ex_data1, day_1_spatial_tree ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education)
full_ST = lm(data= ex_data1, day_1_spatial_tree ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education + exercise_frequency_order)
summary(full_ST)
anova(null_ST, full_ST)


summary(lm(data=ex_data1, day_1_grammatical_reasoning ~ age_at_test))
ex_only_GR = lm(data= ex_data1, day_1_grammatical_reasoning ~ exercise_frequency_order )
null_GR = lm(data= ex_data1, day_1_grammatical_reasoning ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education)
full_GR = lm(data= ex_data1, day_1_grammatical_reasoning ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education + exercise_frequency_order)
summary(full_GR)
anova(null_GR, full_GR)

summary(ex_only_GR)

ex_only_TS = lm(data= ex_data1, day_1_token_search ~ exercise_frequency_order)
null_TS = lm(data= ex_data1, day_1_token_search ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education)
full_TS = lm(data= ex_data1, day_1_token_search ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education + exercise_frequency_order)
summary(full_TS)
anova(null_TS, full_TS)


ex_only_PA = lm(data= ex_data1, day_1_paired_associates ~ exercise_frequency_order)
null_PA = lm(data= ex_data1, day_1_paired_associates ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education)
full_PA = lm(data= ex_data1, day_1_paired_associates ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education + exercise_frequency_order)
summary(full_PA)
anova(null_PA, full_PA)



ex_only_SS = lm(data= ex_data1, day_1_spatial_span ~ exercise_frequency_order)
null_SS = lm(data= ex_data1, day_1_spatial_span ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education)
full_SS = lm(data= ex_data1, day_1_spatial_span ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education + exercise_frequency_order)
summary(full_SS)
anova(null_SS, full_SS)




ex_only_FM = lm(data= ex_data1, day_1_feature_match ~ exercise_frequency_order)
null_FM = lm(data= ex_data1, day_1_feature_match ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education)
full_FM = lm(data= ex_data1, day_1_feature_match ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education + exercise_frequency_order)
summary(full_FM)
anova(null_FM, full_FM)


ex_only_rot = lm(data= ex_data1, day_1_rotations ~ exercise_frequency_order)
null_rot = lm(data= ex_data1, day_1_rotations ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education)
full_rot = lm(data= ex_data1, day_1_rotations ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education + exercise_frequency_order)
summary(full_rot)
anova(null_rot, full_rot)


ex_only_pol = lm(data= ex_data1, day_1_polygons ~ exercise_frequency_order )
null_pol = lm(data= ex_data1, day_1_polygons ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education)
full_pol = lm(data= ex_data1, day_1_polygons ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education + exercise_frequency_order)
summary(full_pol)
anova(null_pol, full_pol)



ex_only_ML = lm(data= ex_data1, day_1_monkey_ladder ~ exercise_frequency_order )
null_ML = lm(data= ex_data1, day_1_monkey_ladder ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education)
full_ML = lm(data= ex_data1, day_1_monkey_ladder ~  hours_slept + sleep_quality + age_at_test + SES_growing_up + education + exercise_frequency_order)
summary(full_ML)
anova(null_ML, full_ML)


#### 10% lowest, 10% age
age = ex_data1$age_at_test
lowest_age = quantile(age, probs = .25)
highest_age = quantile(age, probs = .75)

summary(ex_data1$age_at_test >= highest_age)
summary(ex_data1$age_at_test <= lowest_age)

age_data = subset(ex_data1, age_at_test >= highest_age | age_at_test <= lowest_age)
age_data$age_group = age_data$age_at_test >= highest_age

age_data_old = subset(ex_data1, age_at_test >= highest_age)
age_data_young = subset(ex_data1, age_at_test <= lowest_age)





ex_memory_young = lm(data= age_data_young, day_1_memory ~ exercise_frequency_order)
summary(ex_memory_young)
ex_memory_old = lm(data= age_data_old, day_1_memory ~ exercise_frequency_order)
summary(ex_memory_old)


ex_verbal_young = lm(data= age_data_young, day_1_verbal ~ exercise_frequency_order)
summary(ex_verbal_young)
ex_verbal_old = lm(data= age_data_old, day_1_verbal ~ exercise_frequency_order)
summary(ex_verbal_old)

ex_reasoning_young = lm(data= age_data_young, day_1_reasoning ~ exercise_frequency_order)
summary(ex_reasoning_young)
ex_reasoning_old = lm(data= age_data_old, day_1_reasoning ~ exercise_frequency_order)
summary(ex_reasoning_old)



###ANOVAS

###ALL TASKS

DT_model = lm(data = ex_data1, day_1_double_trouble ~ exercise_frequency)
anova(DT_model)

OOO_model = lm(data = ex_data1, day_1_odd_one_out ~ exercise_frequency)
anova(OOO_model)

ST_model = lm(data = ex_data1, day_1_spatial_tree ~ exercise_frequency)
anova(ST_model)

GR_model = lm(data = ex_data1, day_1_grammatical_reasoning ~ exercise_frequency)
anova(GR_model)

DS_model = lm(data = ex_data1, day_1_digit_span ~ exercise_frequency)
anova(DS_model)

TS_model = lm(data = ex_data1, day_1_token_search ~ exercise_frequency)
anova(TS_model)

PA_model = lm(data = ex_data1, day_1_paired_associates ~ exercise_frequency)
anova(PA_model)

SS_model = lm(data = ex_data1, day_1_spatial_span ~ exercise_frequency)
anova(SS_model)

FM_model = lm(data = ex_data1, day_1_feature_match ~ exercise_frequency)
anova(FM_model)

rot_model = lm(data = ex_data1, day_1_rotations ~ exercise_frequency)
anova(rot_model)

Pol_model = lm(data = ex_data1, day_1_polygons ~ exercise_frequency)
anova(Pol_model)

ML_model = lm(data = ex_data1, day_1_monkey_ladder~ exercise_frequency)
anova(ML_model)



#memory
memory_model = lm(data = ex_data1, day_1_memory ~ exercise_frequency)
anova(memory_model)

none_every_memory = t.test(ex_data1$day_1_memory[ex_data1$exercise_frequency == 'Every day'], ex_data1$day_1_memory[ex_data1$exercise_frequency == 'Not during the past month'])
bf_none_every_memory = ttestBF(ex_data1$day_1_memory[ex_data1$exercise_frequency == 'Every day'], ex_data1$day_1_memory[ex_data1$exercise_frequency == 'Not during the past month'])
cohen.d(ex_data1$day_1_memory[ex_data1$exercise_frequency == 'Every day'], ex_data1$day_1_memory[ex_data1$exercise_frequency == 'Not during the past month'])


none_three_memory = t.test(ex_data1$day_1_memory[ex_data1$exercise_frequency== 'Three or more times a week'], ex_data1$day_1_memory[ex_data1$exercise_frequency == 'Not during the past month'])
bf_none_three_memory = ttestBF(ex_data1$day_1_memory[ex_data$exercise_frequency== 'Three or more times a week'], ex_data1$day_1_memory[ex_data$exercise_frequency == 'Not during the past month'])
cohen.d(ex_data$day_1_memory[ex_data1$exercise_frequency== 'Three or more times a week'], ex_data1$day_1_memory[ex_data$exercise_frequency == 'Not during the past month'])

none_one_memory = t.test(ex_data1$day_1_memory[ex_data1$exercise_frequency == 'Once or twice a week'],ex_data1$day_1_memory[ex_data1$exercise_frequency == 'Not during the past month'])
bf_none_one_memory = ttestBF(ex_data1$day_1_memory[ex_data1$exercise_frequency == 'Once or twice a week'],ex_data1$day_1_memory[ex_data1$exercise_frequency == 'Not during the past month'])
cohen.d(ex_data1$day_1_memory[ex_data1$exercise_frequency == 'Once or twice a week'],ex_data1$day_1_memory[ex_data1$exercise_frequency == 'Not during the past month'])

none_less_memory = t.test(ex_data1$day_1_memory[ex_data1$exercise_frequency == 'Less than once a week'], ex_data1$day_1_memory[ex_data1$exercise_frequency == 'Not during the past month'])
bf_none_less_memory = ttestBF(ex_data1$day_1_memory[ex_data1$exercise_frequency == 'Less than once a week'], ex_data1$day_1_memory[ex_data1$exercise_frequency == 'Not during the past month'])
cohen.d(ex_data1$day_1_memory[ex_data1$exercise_frequency == 'Less than once a week'], ex_data1$day_1_memory[ex_data1$exercise_frequency == 'Not during the past month'])



#verbal

verbal_model = lm(data = ex_data1, day_1_verbal~ exercise_frequency)
anova(verbal_model)

none_every_verbal = t.test(ex_data1$day_1_verbal[ex_data1$exercise_frequency == 'Every day'], ex_data1$day_1_verbal[ex_data1$exercise_frequency == 'Not during the past month'])
none_every_bf_verb = ttestBF(ex_data1$day_1_verbal[ex_data1$exercise_frequency == 'Every day'], ex_data1$day_1_verbal[ex_data1$exercise_frequency == 'Not during the past month'])
chains = posterior(none_every_bf_verb, iterations = 10000)
plot(chains)

cohen.d(ex_data1$day_1_verbal[ex_data1$exercise_frequency == 'Every day'], ex_data1$day_1_verbal[ex_data1$exercise_frequency == 'Not during the past month'])


none_three_verbal = t.test(ex_data1$day_1_verbal[ex_data1$exercise_frequency== 'Three or more times a week'], ex_data1$day_1_verbal[ex_data1$exercise_frequency == 'Not during the past month'])
none_every_bf_verb = ttestBF(ex_data1$day_1_verbal[ex_data$exercise_frequency == 'Three or more times a week'], ex_data1$day_1_verbal[ex_data1$exercise_frequency == 'Not during the past month'])
cohen.d(ex_data1$day_1_verbal[ex_data1$exercise_frequency== 'Three or more times a week'], ex_data1$day_1_verbal[ex_data1$exercise_frequency == 'Not during the past month'])


none_one_verbal = t.test(ex_data1$day_1_verbal[ex_data1$exercise_frequency == 'Once or twice a week'],ex_data1$day_1_verbal[ex_data1$exercise_frequency == 'Not during the past month'])
bf_none_one_verbal = ttestBF(ex_data1$day_1_verbal[ex_data1$exercise_frequency == 'Once or twice a week'],ex_data1$day_1_verbal[ex_data1$exercise_frequency == 'Not during the past month'])
cohen.d(ex_data1$day_1_verbal[ex_data1$exercise_frequency == 'Once or twice a week'],ex_data1$day_1_verbal[ex_data1$exercise_frequency == 'Not during the past month'])

none_less_verbal = t.test(ex_data1$day_1_verbal[ex_data1$exercise_frequency == 'Less than once a week'], ex_data1$day_1_verbal[ex_data1$exercise_frequency == 'Not during the past month'])
bf_none_one_verbal = ttestBF(ex_data1$day_1_verbal[ex_data1$exercise_frequency == 'Less than once a week'],ex_data1$day_1_verbal[ex_data1$exercise_frequency == 'Not during the past month'])
cohen.d(ex_data1$day_1_verbal[ex_data1$exercise_frequency == 'Less than once a week'], ex_data1$day_1_verbal[ex_data1$exercise_frequency == 'Not during the past month'])




#reasoning

reasoning_model = lm(data = ex_data, day_1_reasoning ~ exercise_frequency)
anova(reasoning_model)

none_every_reasoning = t.test(ex_data$day_1_reasoning[ex_data$exercise_frequency == 'Every day'], ex_data$day_1_reasoning[ex_data$exercise_frequency == 'Not during the past month'])
bf_none_every_reasoning = ttestBF(ex_data$day_1_reasoning[ex_data$exercise_frequency == 'Every day'], ex_data$day_1_reasoning[ex_data$exercise_frequency == 'Not during the past month'])
cohen.d(ex_data$day_1_reasoning[ex_data$exercise_frequency == 'Every day'], ex_data$day_1_reasoning[ex_data$exercise_frequency == 'Not during the past month'])

none_three_reasoning = t.test(ex_data$day_1_reasoning[ex_data$exercise_frequency== 'Three or more times a week'], ex_data$day_1_reasoning[ex_data$exercise_frequency == 'Not during the past month'])
bf_none_three_reasoning = ttestBF(ex_data$day_1_reasoning[ex_data$exercise_frequency== 'Three or more times a week'], ex_data$day_1_reasoning[ex_data$exercise_frequency == 'Not during the past month'])
cohen.d(ex_data$day_1_reasoning[ex_data$exercise_frequency== 'Three or more times a week'], ex_data$day_1_reasoning[ex_data$exercise_frequency == 'Not during the past month'])

none_one_reasoning = t.test(ex_data$day_1_reasoning[ex_data$exercise_frequency == 'Once or twice a week'],ex_data$day_1_reasoning[ex_data$exercise_frequency == 'Not during the past month'])
bf_none_one_reasoning = ttestBF(ex_data$day_1_reasoning[ex_data$exercise_frequency == 'Once or twice a week'],ex_data$day_1_reasoning[ex_data$exercise_frequency == 'Not during the past month'])
cohen.d(ex_data$day_1_reasoning[ex_data$exercise_frequency == 'Once or twice a week'],ex_data$day_1_reasoning[ex_data$exercise_frequency == 'Not during the past month'])

none_less_reasoning = t.test(ex_data$day_1_reasoning[ex_data$exercise_frequency == 'Less than once a week'], ex_data$day_1_reasoning[ex_data$exercise_frequency == 'Not during the past month'])
bf_none_less_reasoning = ttestBF(ex_data$day_1_reasoning[ex_data$exercise_frequency == 'Less than once a week'], ex_data$day_1_reasoning[ex_data$exercise_frequency == 'Not during the past month'])
cohen.d(ex_data$day_1_reasoning[ex_data$exercise_frequency == 'Less than once a week'], ex_data$day_1_reasoning[ex_data$exercise_frequency == 'Not during the past month'])






#3x5 anova (test type x exercise)
reas_dat = data.frame(sub = ex_data1$admin_user_id, ex_group = ex_data1$exercise_frequency, score = ex_data1$day_1_reasoning, hours_sleep = ex_data1$hours_slept, qual_sleep = ex_data1$sleep_quality, age = ex_data1$age_at_test, SES = ex_data1$SES_growing_up, Edu = ex_data1$education)
mem_dat = data.frame(sub = ex_data1$admin_user_id, ex_group = ex_data1$exercise_frequency, score = ex_data1$day_1_verbal,  hours_sleep = ex_data1$hours_slept, qual_sleep = ex_data1$sleep_quality, age = ex_data1$age_at_test, SES = ex_data1$SES_growing_up, Edu = ex_data1$education)
ver_dat = data.frame(sub = ex_data1$admin_user_id, ex_group = ex_data1$exercise_frequency, score = ex_data1$day_1_memory,  hours_sleep = ex_data1$hours_slept, qual_sleep = ex_data1$sleep_quality, age = ex_data1$age_at_test, SES = ex_data1$SES_growing_up, Edu = ex_data1$education)
reas_dat$test_type = 'reas'
mem_dat$test_type = 'mem'
ver_dat$test_type = 'ver'
score_dat = rbind(reas_dat, mem_dat, ver_dat)


#2x5 ANOVA 
model2 = aov(data = score_dat, score ~ ex_group * test_type + Error(sub/(test_type)))
model2_summary = summary(model2)

model3 = lm(data = score_dat, score ~ ex_group)
TukeyHSD(aov(model3))

