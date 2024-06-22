WITH EmployeeReview AS (
    SELECT DISTINCT
        `Respondent ID` AS RespondentID,
        STR_TO_DATE (`Start Date`, '%c/%e/%Y') AS StartDate,
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
            WHEN Gender = 'F' THEN 'Female'
            WHEN Gender = 'Femail' THEN 'Female'
            WHEN Gender = 'Females' THEN 'Female'
            WHEN Gender = 'Femalr' THEN 'Female'
            WHEN Gender = 'M' THEN 'Male'
            WHEN Gender = 'male' THEN 'Male'
            WHEN Gender = 'Man' THEN 'Male'
            WHEN Gender = 'Technically female' THEN 'Female'
            ELSE Gender
        END AS Gender,
        CASE
            WHEN Age LIKE '%-%' THEN
                (CAST(SUBSTRING_INDEX(Age, '-', 1) AS DECIMAL) + CAST(SUBSTRING_INDEX(Age, '-', -1) AS DECIMAL)) / 2
            ELSE CAST(Age AS DECIMAL)
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
        ROW_NUMBER() OVER(ORDER BY JobTitle) AS JobTitleID,
        SeniorityLevel,
        CASE
            WHEN Promotions = 'Prefer not to answer' THEN 'NA'
            ELSE Promotions
        END AS Promotions,
        Industry,
        BusinessType,
        CompanySize,
        CASE
            WHEN JobPerformance = 'Declined to Answer' THEN 'NA'
            ELSE JobPerformance
        END AS JobPerformance,
        CASE
            WHEN IsCompensation = 'Declined to Answer' THEN 'NA'
            ELSE IsCompensation
        END AS IsCompensation,
        CASE
            WHEN IsGrowth = 'Declined to Answer' THEN 'NA'
            ELSE IsGrowth
        END AS IsGrowth,
        CASE
            WHEN IsDecisions = 'Declined to Answer' THEN 'NA'
            ELSE IsDecisions
        END AS IsDecisions,
        CASE
            WHEN IsGrowthOpportunities = 'Declined to Answer' THEN 'NA'
            ELSE IsGrowthOpportunities
        END AS IsGrowthOpportunities
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
        AND CompanySize IS NOT NULL
        AND JobPerformance IS NOT NULL
        AND IsCompensation IS NOT NULL
        AND IsGrowth IS NOT NULL
        AND IsDecisions IS NOT NULL
        AND IsGrowthOpportunities IS NOT NULL
),
EmployeeSurvey AS (
    SELECT DISTINCT
        RespondentID,
        PostalCode,
        Salary,
        BonusStatus,
        EmployeeCount AS CompanyEmployeeCount,
        IsFairness
    FROM
        ExcelAnalysis.EmployeeSurvey
    WHERE
        RespondentID IS NOT NULL
        AND PostalCode IS NOT NULL
        AND Salary IS NOT NULL
        AND BonusStatus IS NOT NULL
        AND EmployeeCount IS NOT NULL
        AND IsFairness IS NOT NULL
)

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
    ER.JobTitleID,
    ER.SeniorityLevel,
    ER.Promotions,
    ER.Industry,
    ER.BusinessType,
    ER.CompanySize,
    ER.JobPerformance,
    ER.IsCompensation,
    ER.IsGrowth,
    ER.IsDecisions,
    ER.IsGrowthOpportunities,
    ES.PostalCode,
    ES.Salary,
    ES.BonusStatus,
    ES.CompanyEmployeeCount,
    ES.IsFairness
FROM
    EmployeeReview AS ER
    INNER JOIN EmployeeSurvey AS ES ON ER.RespondentID = ES.RespondentID;
