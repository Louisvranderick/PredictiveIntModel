# Predicting Interceptions in NFL Pass Plays

## Introduction
This GitHub repository contains R code for predicting interceptions in NFL pass plays using the `nflfastR` library. The script focuses on analyzing the relationship between interception occurrences, passer behavior, and the total line for over-under scores. This README provides an overview of the code, its methodology, and instructions on how to use it.

## Table of Contents
- [Introduction](#introduction)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Data Source](#data-source)
- [Methodology](#methodology)
- [Results](#results)
- [Contributing](#contributing)
- [License](#license)

## Requirements
To run this code, you need to have R installed, along with the following libraries:
- `nflfastR`
- `tidyverse`

You can install these packages using the following commands in R:
```R
install.packages(c("nflfastR", "tidyverse"))
```

## Installation
1. Clone this repository to your local machine using Git:
   ```bash
   git clone https://github.com/yourusername/your-repo.git
   ```

2. Navigate to the repository directory:
   ```bash
   cd your-repo
   ```

3. Open the R script in your preferred R environment and run the code.

## Usage
The provided R script analyzes NFL play-by-play data to predict interceptions in pass plays. Simply run the script in your R environment to obtain the results.

## Data Source
The data used in this analysis is sourced from the `nflfastR` package, containing detailed information about NFL plays and player statistics.

## Methodology 
The script employs a Poisson regression approach to model the number of interceptions in NFL pass plays. The Poisson distribution is a statistical model that describes the number of events occurring within a fixed interval of time or space. In this context, the lambda parameter in the Poisson distribution represents the average rate of interceptions, considering passIntRate (average interceptions per game) and total_line (over-under score) as predictors.

The code in the script performs the following steps:
1. Loads play-by-play data using `nflfastR`.
2. Filters and cleans the data to focus on pass plays with necessary attributes.
3. Calculates summary statistics for pass plays with at least 10 passes.
4. Utilizes a Poisson regression model to predict interceptions.
5. Calculates Poisson probabilities for different interception counts.

## Results
The code outputs results based on the applied Poisson regression model. It provides insights into interception predictions for NFL pass plays, with the option to filter and print results for specific passers and seasons.

## Contributing
If you would like to contribute to this project or have suggestions for improvements, please open an issue or submit a pull request on GitHub.

## License
This project is licensed under the [MIT License](LICENSE), allowing free use, modification, and distribution of the code with the inclusion of the original license and disclaimer.
