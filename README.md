# Predictive interception model
Predictive interception model for quarterbacks using R. 

Thank you to Eric A. Eager and Richard A. Erickson for this method I learnt in their Football Analytics with Python & R: Learning Data Science Through the Lens of Sports Book. 

## Poisson distribution

In this model we use a Poisson distribution to layout the probability of an interception. Like it is said in the book its important to know that a poisson distribution is not ideal for such a case because a Poisson distribution needs an event to occur with equal probability and that the events are independent of the time of the last event. In a game a defense can scheme around what they have seen so far from the 
Qb and adjust their defenses so we could not say that these events are independent of the time of the last event. 




