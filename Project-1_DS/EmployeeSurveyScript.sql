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
    WHEN LTRIM(RTRIM(LOWER(IsGrowth))) = 'somewhat agree' THEN 4
    WHEN LTRIM(RTRIM(LOWER(IsGrowth))) = 'neither agree nor disagree' THEN 5
    WHEN LTRIM(RTRIM(LOWER(IsGrowth))) = 'disagree' THEN 6
    WHEN LTRIM(RTRIM(LOWER(IsGrowth))) = 'declined to answer' THEN 7
    WHEN LTRIM(RTRIM(LOWER(IsGrowth))) = 'agree' THEN 8
END AS IsGrowthID,
        IsDecisions,
        CASE 
    WHEN LTRIM(RTRIM(LOWER(IsDecisions))) = 'strongly disagree' THEN 1
    WHEN LTRIM(RTRIM(LOWER(IsDecisions))) = 'strongly agree' THEN 2
    WHEN LTRIM(RTRIM(LOWER(IsDecisions))) = 'somewhat disagree' THEN 3
    WHEN LTRIM(RTRIM(LOWER(IsDecisions))) = 'somewhat agree' THEN 4
    WHEN LTRIM(RTRIM(LOWER(IsDecisions))) = 'neither agree nor disagree' THEN 5
    WHEN LTRIM(RTRIM(LOWER(IsDecisions))) = 'disagree' THEN 6
    WHEN LTRIM(RTRIM(LOWER(IsDecisions))) = 'declined to answer' THEN 7
    WHEN LTRIM(RTRIM(LOWER(IsDecisions))) = 'agree' THEN 8
END AS IsDecisionsID,
        IsGrowthOpportunities,
        CASE 
    WHEN LTRIM(RTRIM(LOWER(IsGrowthOpportunities))) = 'strongly disagree' THEN 1
    WHEN LTRIM(RTRIM(LOWER(IsGrowthOpportunities))) = 'strongly agree' THEN 2
    WHEN LTRIM(RTRIM(LOWER(IsGrowthOpportunities))) = 'somewhat disagree' THEN 3
    WHEN LTRIM(RTRIM(LOWER(IsGrowthOpportunities))) = 'somewhat agree' THEN 4
    WHEN LTRIM(RTRIM(LOWER(IsGrowthOpportunities))) = 'neither agree nor disagree' THEN 5
    WHEN LTRIM(RTRIM(LOWER(IsGrowthOpportunities))) = 'disagree' THEN 6
    WHEN LTRIM(RTRIM(LOWER(IsGrowthOpportunities))) = 'declined to answer' THEN 7
    WHEN LTRIM(RTRIM(LOWER(IsGrowthOpportunities))) = 'agree' THEN 8
END AS IsGrowthOpportunitiesID
    FROM
        ExcelAnalysis.EmployeeReview
    WHERE
        `Respondent ID` IS NOT NULL
        AND `Start Date` IS NOT NULL
        AND Race IS NOT NULL
        AND Gender IS NOT NULL
        AND (Age IS NOT NULL AND Age != '')
        AND EducationLevel IS NOT NULL
        AND EmploymentType IS NOT NULL
        AND ExperienceLevel IS NOT NULL
        AND JobTitle IS NOT NULL
        AND SeniorityLevel IS NOT NULL
        AND Promotions IS NOT NULL
        AND Industry IS NOT NULL
        AND BusinessType IS NOT NULL
        AND JobPerformance IS NOT NULL
        AND IsCompensation IS NOT NULL
        AND IsGrowth IS NOT NULL
        AND IsDecisions IS NOT NULL
        AND IsGrowthOpportunities IS NOT NULL
),
-- Creating a CTE to clean and standardize EmployeeSurvey data
EmployeeSurvey AS (
    SELECT DISTINCT
        RespondentID,
        PostalCode,
        Salary,
        BonusStatus,
        EmployeeCount,
        CASE 
            WHEN EmployeeCount = '1,000 to 10,000 Employees' THEN 1
            WHEN EmployeeCount = '250 to 1,000 Employees' THEN 2
            WHEN EmployeeCount = '50 to 250 Employees' THEN 3
            WHEN EmployeeCount = 'Less than 50 Employees' THEN 4
            WHEN EmployeeCount = 'More than 10,000 Employees' THEN 5
        END AS CompanyEmployeeCountID,
        IsFairness,
        CASE 
    WHEN LTRIM(RTRIM(LOWER(IsFairness))) = 'strongly disagree' THEN 1
    WHEN LTRIM(RTRIM(LOWER(IsFairness))) = 'strongly agree' THEN 2
    WHEN LTRIM(RTRIM(LOWER(IsFairness))) = 'somewhat disagree' THEN 3
    WHEN LTRIM(RTRIM(LOWER(IsFairness))) = 'somewhat agree' THEN 4
    WHEN LTRIM(RTRIM(LOWER(IsFairness))) = 'neither agree nor disagree' THEN 5
    WHEN LTRIM(RTRIM(LOWER(IsFairness))) = 'disagree' THEN 6
    WHEN LTRIM(RTRIM(LOWER(IsFairness))) = 'declined to answer' THEN 7
    WHEN LTRIM(RTRIM(LOWER(IsFairness))) = 'agree' THEN 8
END AS IsFairnessID
    FROM
        ExcelAnalysis.EmployeeSurvey
    WHERE
        RespondentID IS NOT NULL
        AND PostalCode IS NOT NULL
        AND Salary IS NOT NULL
        AND BonusStatus IS NOT NULL
        AND EmployeeCount IS NOT NULL
        AND IsFairness IS NOT NULL
),

-- Creating mappings for various columns using ROW_NUMBER()
JobTitleMapping AS (
    SELECT DISTINCT LTRIM(RTRIM(LOWER(JobTitle))) AS JobTitle, ROW_NUMBER() OVER (ORDER BY LTRIM(RTRIM(LOWER(JobTitle)))) AS JobTitleID FROM EmployeeReview
),
SeniorityLevelMapping AS (
    SELECT DISTINCT LTRIM(RTRIM(LOWER(SeniorityLevel))) AS SeniorityLevel, ROW_NUMBER() OVER (ORDER BY LTRIM(RTRIM(LOWER(SeniorityLevel)))) AS SeniorityLevelID FROM EmployeeReview
),
IndustryMapping AS (
    SELECT DISTINCT LTRIM(RTRIM(LOWER(Industry))) AS Industry, ROW_NUMBER() OVER (ORDER BY LTRIM(RTRIM(LOWER(Industry)))) AS IndustryID FROM EmployeeReview
),
BonusStatusMapping AS (
    SELECT DISTINCT LTRIM(RTRIM(LOWER(BonusStatus))) AS BonusStatus, ROW_NUMBER() OVER (ORDER BY LTRIM(RTRIM(LOWER(BonusStatus)))) AS BonusStatusID FROM EmployeeSurvey
)

-- Final SELECT statement to join the data and mappings
SELECT
    ER.RespondentID,
    ER.StartDate,
    ER.Race,
    ER.RaceID,
    ER.Gender,
    CASE 
        WHEN ER.Gender = 'Female' THEN 1
        WHEN ER.Gender = 'Male' THEN 2
    END AS GenderID,
    ROUND(ER.Age) AS Age,
    ER.EducationLevel,
    ER.EducationLevelID,
    ER.EmploymentType,
    ER.EmploymentTypeID,
    ER.ExperienceLevel,
    ER.ExperienceLevelID,
    ER.JobTitle,
    JTM.JobTitleID,
    ER.SeniorityLevel,
    SLM.SeniorityLevelID,
    ER.Promotions,
    ER.PromotionsID,
    ER.Industry,
    IM.IndustryID,
    ER.BusinessType,
    ER.BusinessTypeID,
    ER.JobPerformance,
    ER.JobPerformanceID,
    ER.IsCompensation,
    ER.IsCompensationID,
    ER.IsGrowth,
    ER.IsGrowthID,
    ER.IsDecisions,
    ER.IsDecisionsID,
    ER.IsGrowthOpportunities,
    ER.IsGrowthOpportunitiesID,
    ES.PostalCode,
    ES.Salary,
    ES.BonusStatus,
    BSM.BonusStatusID,
    ES.EmployeeCount,
    ES.CompanyEmployeeCountID,
    ES.IsFairness,
    ES.IsFairnessID
FROM
    EmployeeReview AS ER
    INNER JOIN EmployeeSurvey AS ES ON ER.RespondentID = ES.RespondentID
    INNER JOIN JobTitleMapping AS JTM ON LTRIM(RTRIM(LOWER(ER.JobTitle))) = LTRIM(RTRIM(LOWER(JTM.JobTitle)))
    INNER JOIN SeniorityLevelMapping AS SLM ON LTRIM(RTRIM(LOWER(ER.SeniorityLevel))) = LTRIM(RTRIM(LOWER(SLM.SeniorityLevel)))
    INNER JOIN IndustryMapping AS IM ON LTRIM(RTRIM(LOWER(ER.Industry))) = LTRIM(RTRIM(LOWER(IM.Industry)))
    INNER JOIN BonusStatusMapping AS BSM ON LTRIM(RTRIM(LOWER(ES.BonusStatus))) = LTRIM(RTRIM(LOWER(BSM.BonusStatus)))
    );
