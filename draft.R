library(creditmodel)
library(dplyr)
library(ROSE)

df <- read.csv("data/credit_dataset.csv") %>% select(-c(X, ID)) %>% mutate(TARGET = as.factor(TARGET))

train_test <- train_test_split(df, prop = 0.7, split_type = "OOT")

train <- train_test$train
test <- train_test$test

train_resample <- ovun.sample(eval(parse(text = "TARGET~.")), train, method="over", p=0.2, seed = 42)$data



library(randomForest)
model <- randomForest(TARGET ~ ., data = train_resample, ntree = 200, na.action = na.omit)


test$predicted <- predict(model, test)
library(caret)
conf <- confusionMatrix(data = test$predicted, reference = test$TARGET)
conf
