WITH
    BaseData AS (
        SELECT
            PIC.NIK AS PIC_POS,
            CASE
                WHEN AA.LicensePlate IS NOT NULL
                AND LTRIM(RTRIM(AA.LicensePlate)) <> '' THEN AA.LicensePlate
                ELSE SD.License_Plate
            END AS LicensePlate_fix,
            SD.*,
            PMOT.*
        FROM
            [dwvirtu].[DB_PMO_Dev].[dbo].[SourceData_BravoSalestrax] AS SD
        WITH
            (NOLOCK)
            LEFT JOIN [DWBIBFI2_STG].[dbo].[STG_AgreementAsset] AS AA
        WITH
            (NOLOCK) ON SD.[ApplicationID] = AA.[ApplicationID]
            INNER JOIN [dwvirtu].[DB_PMO_Dev].[dbo].[POS_PIC_NIK] AS PIC
        WITH
            (NOLOCK) ON SD.Marketing2ID = PIC.NIK
            AND PIC.NIK <> ''
            LEFT JOIN [dwvirtu].[DB_PMO_Dev].[dbo].[POS_PMO Tools] AS PMOT
        WITH
            (NOLOCK) ON PMOT.pos_interest_asset_licenseplate = CASE
                WHEN AA.LicensePlate IS NOT NULL
                AND LTRIM(RTRIM(AA.LicensePlate)) <> '' THEN AA.LicensePlate
                ELSE SD.License_Plate
            END
        WHERE
            SD.Marketing2ID IS NOT NULL
        UNION ALL
        SELECT
            PIC.NIK AS PIC_POS,
            CASE
                WHEN AA.LicensePlate IS NOT NULL
                AND LTRIM(RTRIM(AA.LicensePlate)) <> '' THEN AA.LicensePlate
                ELSE SD.License_Plate
            END AS LicensePlate_fix,
            SD.*,
            PMOT.*
        FROM
            [dwvirtu].[DB_PMO_Dev].[dbo].[SourceData_BravoSalestrax] AS SD
        WITH
            (NOLOCK)
            LEFT JOIN [DWBIBFI2_STG].[dbo].[STG_AgreementAsset] AS AA
        WITH
            (NOLOCK) ON SD.[ApplicationID] = AA.[ApplicationID]
            INNER JOIN [DWBIBFI2_STG].[dbo].[STG_MarketingEmployee] AS MKTE
        WITH
            (NOLOCK) ON SD.Marketing2ID = MKTE.EmployeeID
            INNER JOIN [dwvirtu].[DB_PMO_Dev].[dbo].[POS_PIC_NIK] AS PIC
        WITH
            (NOLOCK) ON MKTE.NIK = PIC.NIK
            AND PIC.NIK <> ''
            LEFT JOIN [dwvirtu].[DB_PMO_Dev].[dbo].[POS_PMO Tools] AS PMOT
        WITH
            (NOLOCK) ON PMOT.pos_interest_asset_licenseplate = CASE
                WHEN AA.LicensePlate IS NOT NULL
                AND LTRIM(RTRIM(AA.LicensePlate)) <> '' THEN AA.LicensePlate
                ELSE SD.License_Plate
            END
        WHERE
            SD.Marketing2ID IS NOT NULL
            AND SD.InputBy_ID IN ('cno2w999', 'cno4w999')
        UNION ALL
        SELECT
            PIC.NIK AS PIC_POS,
            CASE
                WHEN AA.LicensePlate IS NOT NULL
                AND LTRIM(RTRIM(AA.LicensePlate)) <> '' THEN AA.LicensePlate
                ELSE SD.License_Plate
            END AS LicensePlate_fix,
            SD.*,
            PMOT.*
        FROM
            [dwvirtu].[DB_PMO_Dev].[dbo].[SourceData_BravoSalestrax] AS SD
        WITH
            (NOLOCK)
            LEFT JOIN [DWBIBFI2_STG].[dbo].[STG_AgreementAsset] AS AA
        WITH
            (NOLOCK) ON SD.[ApplicationID] = AA.[ApplicationID]
            INNER JOIN [DWBIBFI2_STG].[dbo].[STG_MarketingEmployee] AS MKTE
        WITH
            (NOLOCK) ON SD.InputBy_ID = MKTE.EmployeeID
            INNER JOIN [dwvirtu].[DB_PMO_Dev].[dbo].[POS_PIC_NIK] AS PIC
        WITH
            (NOLOCK) ON MKTE.NIK = PIC.NIK
            AND PIC.NIK <> ''
            LEFT JOIN [dwvirtu].[DB_PMO_Dev].[dbo].[POS_PMO Tools] AS PMOT
        WITH
            (NOLOCK) ON PMOT.pos_interest_asset_licenseplate = CASE
                WHEN AA.LicensePlate IS NOT NULL
                AND LTRIM(RTRIM(AA.LicensePlate)) <> '' THEN AA.LicensePlate
                ELSE SD.License_Plate
            END
        WHERE
            SD.Marketing2ID IS NULL
            OR SD.Marketing2ID = ''
        UNION ALL
        SELECT
            PIC.NIK AS PIC_POS,
            CASE
                WHEN AA.LicensePlate IS NOT NULL
                AND LTRIM(RTRIM(AA.LicensePlate)) <> '' THEN AA.LicensePlate
                ELSE SD.License_Plate
            END AS LicensePlate_fix,
            SD.*,
            PMOT.*
        FROM
            [dwvirtu].[DB_PMO_Dev].[dbo].[SourceData_BravoSalestrax] AS SD
        WITH
            (NOLOCK)
            LEFT JOIN [DWBIBFI2_STG].[dbo].[STG_AgreementAsset] AS AA
        WITH
            (NOLOCK) ON SD.[ApplicationID] = AA.[ApplicationID]
            INNER JOIN [DWBIBFI2_STG].[dbo].[STG_BravoLOS_onboarding_application_form] AS BROF
        WITH
            (NOLOCK) ON SD.Bravo_LeadID = BROF.ID
            INNER JOIN [dwvirtu].[DB_PMO_Dev].[dbo].[POS_PIC_NIK] AS PIC
        WITH
            (NOLOCK) ON BROF.initial_marketing_id = PIC.NIK
            AND PIC.NIK <> ''
            LEFT JOIN [dwvirtu].[DB_PMO_Dev].[dbo].[POS_PMO Tools] AS PMOT
        WITH
            (NOLOCK) ON PMOT.pos_interest_asset_licenseplate = CASE
                WHEN AA.LicensePlate IS NOT NULL
                AND LTRIM(RTRIM(AA.LicensePlate)) <> '' THEN AA.LicensePlate
                ELSE SD.License_Plate
            END
        WHERE
            SD.Marketing2ID IS NULL
            AND SD.InputBy_ID IN ('cno2w999', 'cno4w999')
            AND SD.Proses = 'Bravo LOS'
        UNION ALL
        SELECT
            PIC.NIK AS PIC_POS,
            CASE
                WHEN AA.LicensePlate IS NOT NULL
                AND LTRIM(RTRIM(AA.LicensePlate)) <> '' THEN AA.LicensePlate
                ELSE SD.License_Plate
            END AS LicensePlate_fix,
            SD.*,
            PMOT.*
        FROM
            [dwvirtu].[DB_PMO_Dev].[dbo].[SourceData_BravoSalestrax] AS SD
        WITH
            (NOLOCK)
            LEFT JOIN [DWBIBFI2_STG].[dbo].[STG_AgreementAsset] AS AA
        WITH
            (NOLOCK) ON SD.[ApplicationID] = AA.[ApplicationID]
            INNER JOIN [DWBIBFI2_STG].[dbo].[STG_ST_Customer] AS STC
        WITH
            (NOLOCK) ON SD.On_Boarding_Lead_ID = STC.Cust_appID
            INNER JOIN [dwvirtu].[DB_PMO_Dev].[dbo].[POS_PIC_NIK] AS PIC
        WITH
            (NOLOCK) ON STC.InputBy = PIC.NIK
            AND PIC.NIK <> ''
            LEFT JOIN [dwvirtu].[DB_PMO_Dev].[dbo].[POS_PMO Tools] AS PMOT
        WITH
            (NOLOCK) ON PMOT.pos_interest_asset_licenseplate = CASE
                WHEN AA.LicensePlate IS NOT NULL
                AND LTRIM(RTRIM(AA.LicensePlate)) <> '' THEN AA.LicensePlate
                ELSE SD.License_Plate
            END
        WHERE
            SD.Marketing2ID IS NULL
            AND SD.InputBy_ID IN ('cno2w999', 'cno4w999')
            AND SD.Proses = 'Salestrax'
        UNION ALL
        SELECT
            PIC_POS = '93975',
            CASE
                WHEN AA.LicensePlate IS NOT NULL
                AND LTRIM(RTRIM(AA.LicensePlate)) <> '' THEN AA.LicensePlate
                ELSE SD.License_Plate
            END AS LicensePlate_fix,
            SD.*,
            PMOT.*
        FROM
            [dwvirtu].[DB_PMO_Dev].[dbo].[SourceData_BravoSalestrax] AS SD
        WITH
            (NOLOCK)
            LEFT JOIN [DWBIBFI2_STG].[dbo].[STG_AgreementAsset] AS AA
        WITH
            (NOLOCK) ON SD.[ApplicationID] = AA.[ApplicationID]
            LEFT JOIN [dwvirtu].[DB_PMO_Dev].[dbo].[POS_PMO Tools] AS PMOT
        WITH
            (NOLOCK) ON PMOT.pos_interest_asset_licenseplate = CASE
                WHEN AA.LicensePlate IS NOT NULL
                AND LTRIM(RTRIM(AA.LicensePlate)) <> '' THEN AA.LicensePlate
                ELSE SD.License_Plate
            END
            AND SD.license_plate <> ''
        WHERE
            (
                SD.Marketing2ID = 'fahi999'
                OR SD.Marketing2ID = '093975'
            )
            AND SD.SK_Time BETWEEN '202408' AND '202412'
    ),
    RankedData AS (
        SELECT
            *,
            ROW_NUMBER() OVER (
                PARTITION BY
                    CASE
                        WHEN LicensePlate_fix IS NULL
                        OR LTRIM(RTRIM(LicensePlate_fix)) IN ('', '-') THEN 'ALL_NULL_BLANK_DASH'
                        ELSE LicensePlate_fix
                    END,
                    pos_interest_loc,
                    AgreementNo,
                    FORMAT(Lead_Date, 'yyyy-MM')
                ORDER BY
                    CASE
                        WHEN GoLive_Date IS NOT NULL THEN 6
                        WHEN Approval_Date IS NOT NULL THEN 5
                        WHEN Surveyor_Date IS NOT NULL THEN 4
                        WHEN Closing_Date IS NOT NULL THEN 3
                        WHEN Lead_Date IS NOT NULL THEN 2
                        ELSE 1
                    END DESC,
                    GoLive_Date DESC,
                    Approval_Date DESC,
                    Surveyor_Date DESC,
                    Closing_Date DESC,
                    Lead_Date DESC
            ) AS idxBY_LicensePlate,
            ROW_NUMBER() OVER (
                PARTITION BY
                    On_Boarding_Lead_ID,
                    CASE
                        WHEN LicensePlate_fix IS NULL
                        OR LTRIM(RTRIM(LicensePlate_fix)) IN ('', '-') THEN 'ALL_NULL_BLANK_DASH'
                        ELSE LicensePlate_fix
                    END,
                    pos_interest_loc,
                    AgreementNo,
                    FORMAT(Lead_Date, 'yyyy-MM')
                ORDER BY
                    CASE
                        WHEN GoLive_Date IS NOT NULL THEN 6
                        WHEN Approval_Date IS NOT NULL THEN 5
                        WHEN Surveyor_Date IS NOT NULL THEN 4
                        WHEN Closing_Date IS NOT NULL THEN 3
                        WHEN Lead_Date IS NOT NULL THEN 2
                        ELSE 1
                    END DESC,
                    GoLive_Date DESC,
                    Approval_Date DESC,
                    Surveyor_Date DESC,
                    Closing_Date DESC,
                    Lead_Date DESC
            ) AS idxBY_LeadID
        FROM
            BaseData
    )
SELECT
    *
FROM
    RankedData