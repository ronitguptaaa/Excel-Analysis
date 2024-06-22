WITH EmployeeReview AS (
    SELECT DISTINCT
        `Respondent ID` AS RespondentID,
        STR_TO_DATE (`Start Date`, '%c/%e/%Y') AS StartDate,
        CASE
            WHEN Race = 'Prefer not to say' THEN 'NA'
            WHEN Race = 'Declined to Answer' THEN 'NA'
            ELSE Race
        END AS Race,
        CASE
            WHEN Gender = 'F' THEN 'Female'
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
        EmploymentType,
        ExperienceLevel,
        JobTitle,
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
    ER.Gender,
    ROUND(ER.Age) AS Age,
    ER.EducationLevel,
    ER.EmploymentType,
    ER.ExperienceLevel,
    ER.JobTitle,
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
