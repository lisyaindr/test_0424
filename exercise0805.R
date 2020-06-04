data("flights")
data("airlines")
data("airports")
data("weather")
#q1: find all fligths on jan1
flights %>% filter(month == 1, day == 1)

#q2: try to find arrival delay (arr_delay) more than 120 minutes and show arr_delay in the fourth coloumn
flights %>% filter(arr_delay >= 120) %>%
      select(year:day, arr_delay, everything())

# q3:find the longest arr_delay and its carrier, flights
# we need to think which function can rank data in descending order
use arrange
flights %>% arrange(desc(arr_delay)) %>%
            select (year:day, carrier, flight, arr_delay, everything()) %>%
            slice(1)  

# q4: which carrier has the worse average arr_delay? its value
use group, summarise, mutate, and arrange
flights %>% group_by(carrier) %>%
  mutate(arr_delay_avg = mean(arr_delay, na.rm= TRUE)) %>%
  summarise(arr_delay = mean(arr_delay, na.rm=TRUE)) %>%
  arrange(desc(arr_delay))

q5: which hour should we take if we try avoiding the possible arr_delay? (use average delay)
#use group_by(hour)
flights %>% group_by(hour) %>%
  mutate(arr_delay_avg = mean(arr_delay))

q6: select the first 100 data of the year, month, day, hour, origin, dest, tailnum, carrier.
#use left_join to add airline names to answer on the above
flights %>%
  left_join(airlines)

q7: count the number of flights for dest = ALB, BDL and BTV in each month. (use 'n()')
flights %>%
  group_by(dest) %>%
  summarise(count= n())
