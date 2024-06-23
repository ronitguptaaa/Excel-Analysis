-- Creating a CTE to clean and standardize EmployeeReview data

CREATE TABLE CompleteEmployeeSurveyDetails AS (
WITH EmployeeReview AS (
    SELECT DISTINCT
        `Respondent ID` AS RespondentID,
        STR_TO_DATE(`Start Date`, '%c/%e/%Y %H:%i') AS StartDate,
        Race,
        CASE
            WHEN Race = 'Asian' THEN 1
            WHEN Race = 'Black and white' THEN 2
            WHEN Race = 'Black or African American' THEN 3
            WHEN Race = 'Hispanic or Latino' THEN 4
            WHEN Race = 'Indian' THEN 5
            WHEN Race = 'Multiracial or Multiethnic' THEN 6
            WHEN Race = 'Native American or Alaska Native' THEN 7
            WHEN Race = 'White' THEN 8
            WHEN Race = 'Prefer not to say' THEN 9
            WHEN Race = 'Declined to Answer' THEN 10
        END AS RaceID,
        CASE
            WHEN Gender IN ('F', 'Femail', 'Females', 'Femalr', 'Technically female') THEN 'Female'
            WHEN Gender IN ('M', 'male', 'Man') THEN 'Male'
            ELSE Gender
        END AS Gender,
        CASE
            WHEN Age LIKE '%-%' THEN
                (CAST(SUBSTRING_INDEX(Age, '-', 1) AS DECIMAL) + CAST(SUBSTRING_INDEX(Age, '-', -1) AS DECIMAL)) / 2
            WHEN Age LIKE '%+%' THEN
                CAST(SUBSTRING_INDEX(Age, '+', 1) AS DECIMAL)
            ELSE
                CAST(Age AS DECIMAL)
        END AS Age,
        EducationLevel,
        CASE 
            WHEN EducationLevel = 'High School Diploma/GED' THEN 1
            WHEN EducationLevel = 'Vocational/Technical School' THEN 2
            WHEN EducationLevel = 'Some High School' THEN 3
            WHEN EducationLevel = 'Some College' THEN 4
            WHEN EducationLevel = 'Associate''s Degree' THEN 5
            WHEN EducationLevel = 'Bachelor''s Degree' THEN 6
            WHEN EducationLevel = 'Master''s Degree or Higher' THEN 7
        END AS EducationLevelID,
        EmploymentType,
        CASE 
            WHEN EmploymentType = 'Unemployed' THEN 1
            WHEN EmploymentType = 'Temporary/Seasonal' THEN 2
            WHEN EmploymentType = 'Short Term Contract Employee' THEN 3
            WHEN EmploymentType = 'Part Time Employee' THEN 4
            WHEN EmploymentType = 'Long Term Contract Employee' THEN 5
            WHEN EmploymentType = 'Full Time Employee' THEN 6
            WHEN EmploymentType = 'Self Employed/Entrepreneur' THEN 7
        END AS EmploymentTypeID,
        ExperienceLevel,
        CASE 
            WHEN ExperienceLevel = 'Less than one year' THEN 1
            WHEN ExperienceLevel = 'One to five years' THEN 2
            WHEN ExperienceLevel = 'Five to ten years' THEN 3
            WHEN ExperienceLevel = 'Ten years or more' THEN 4
            WHEN ExperienceLevel = 'Declined to Answer' THEN 5
        END AS ExperienceLevelID,
        JobTitle,
        SeniorityLevel,
        Promotions,
        CASE 
            WHEN Promotions = 'In the last 1 to 5 years' THEN 1
            WHEN Promotions = 'More than 5 years' THEN 2
            WHEN Promotions = 'Multiple Promotions' THEN 3
            WHEN Promotions = 'Never been promoted' THEN 4
            WHEN Promotions = 'Prefer not to answer' THEN 5
            WHEN Promotions = 'Within 12 Months' THEN 6
        END AS PromotionsID,
        Industry,
        BusinessType,
        CASE 
            WHEN BusinessType = 'For Profit' THEN 1
            WHEN BusinessType = 'Government' THEN 2
            WHEN BusinessType = 'Non Profit' THEN 3
            WHEN BusinessType = 'Unknown' THEN 4
        END AS BusinessTypeID,
        JobPerformance,
        CASE 
    WHEN LTRIM(RTRIM(LOWER(JobPerformance))) = 'strongly disagree' THEN 1
    WHEN LTRIM(RTRIM(LOWER(JobPerformance))) = 'strongly agree' THEN 2
    WHEN LTRIM(RTRIM(LOWER(JobPerformance))) = 'somewhat disagree' THEN 3
    WHEN LTRIM(RTRIM(LOWER(JobPerformance))) = 'somewhat agree' THEN 4
    WHEN LTRIM(RTRIM(LOWER(JobPerformance))) = 'neither agree nor disagree' THEN 5
    WHEN LTRIM(RTRIM(LOWER(JobPerformance))) = 'disagree' THEN 6
    WHEN LTRIM(RTRIM(LOWER(JobPerformance))) = 'declined to answer' THEN 7
    WHEN LTRIM(RTRIM(LOWER(JobPerformance))) = 'agree' THEN 8
END AS JobPerformanceID,
        IsCompensation,
        CASE 
    WHEN LTRIM(RTRIM(LOWER(IsCompensation))) = 'strongly disagree' THEN 1
    WHEN LTRIM(RTRIM(LOWER(IsCompensation))) = 'strongly agree' THEN 2
    WHEN LTRIM(RTRIM(LOWER(IsCompensation))) = 'somewhat disagree' THEN 3
    WHEN LTRIM(RTRIM(LOWER(IsCompensation))) = 'somewhat agree' THEN 4
    WHEN LTRIM(RTRIM(LOWER(IsCompensation))) = 'neither agree nor disagree' THEN 5
    WHEN LTRIM(RTRIM(LOWER(IsCompensation))) = 'disagree' THEN 6
    WHEN LTRIM(RTRIM(LOWER(IsCompensation))) = 'declined to answer' THEN 7
    WHEN LTRIM(RTRIM(LOWER(IsCompensation))) = 'agree' THEN 8
END AS IsCompensationID,
        IsGrowth,
        CASE 
    WHEN LTRIM(RTRIM(LOWER(IsGrowth))) = 'strongly disagree' THEN 1
    WHEN LTRIM(RTRIM(LOWER(IsGrowth))) = 'strongly agree' THEN 2
    WHEN LTRIM(RTRIM(LOWER(IsGrowth))) = 'somewhat disagree' THEN 3
    WHEN LT