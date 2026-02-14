# Load libraries
library(dplyr)
library(tidyr)
library(ggplot2)

# Create a small dataset
students <- data.frame(
  Name = c("Alice", "Bob", "Charlie", "Diana", "Ethan"),
  Math = c(85, 92, 78, 88, 95),
  Science = c(90, 85, 80, 87, 93),
  English = c(88, 90, 82, 91, 94)
)

# Average grade per student
students$Average <- rowMeans(students[,2:4])

# Average grade per subject
avg_grades <- students %>%
  summarise(
    Avg_Math = mean(Math),
    Avg_Science = mean(Science),
    Avg_English = mean(English)
  )

print(avg_grades)

# Top students
top_students <- students %>%
  arrange(desc(Average))
print(top_students)

# Convert avg_grades to long format for plotting
avg_grades_long <- avg_grades %>%
  gather(key = "Subject", value = "Average")

# Bar plot: average grades per subject
ggplot(avg_grades_long, aes(x = Subject, y = Average, fill = Subject)) +
  geom_bar(stat = "identity") +
  ylim(0, 100) +
  ggtitle("Average Grades per Subject") +
  theme_minimal()

# Histogram: distribution of student averages
ggplot(students, aes(x = Average)) +
  geom_histogram(binwidth = 5, fill = "skyblue", color = "black") +
  ggtitle("Distribution of Student Average Grades") +
  xlab("Average Grade") +
  ylab("Number of Students") +
  theme_minimal()
