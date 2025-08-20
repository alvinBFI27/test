WITH
    BaseData AS (
        /* ==================== 
        UNION 1: Mapping langsung Marketing2ID ke NIK di POS_PIC_NIK
        - Ambil PIC.NIK sebagai PIC_POS
        - Join ke STG_AgreementAsset untuk LicensePlate
        - Join ke POS_PMO Tools pakai LicensePlate
        - Hanya data yang Marketing2ID IS NOT NULL
        ==================== */
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
        /* ==================== 
        UNION 2: Mapping via STG_MarketingEmployee
        - SD.Marketing2ID dicocokkan dengan EmployeeID
        - Dari situ ambil NIK dan match ke POS_PIC_NIK
        - Tambahan filter InputBy_ID khusus ('cno2w999', 'cno4w999')
        ==================== */
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
        /* ==================== 
        UNION 3: Jika Marketing2ID kosong, gunakan InputBy_ID → EmployeeID → NIK → POS_PIC_NIK
        ==================== */
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
        /* ==================== 
        UNION 4: Jika Marketing2ID NULL dan Proses = 'Bravo LOS'
        - Join via BravoLOS onboarding form (BROF)
        - Ambil initial_marketing_id → POS_PIC_NIK
        - Khusus InputBy_ID = 'cno2w999' atau 'cno4w999'
        ==================== */
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
        /* ==================== 
        UNION 5: Jika Marketing2ID NULL dan Proses = 'Salestrax'
        - Join via ST_Customer
        - Mapping InputBy → POS_PIC_NIK
        - Khusus InputBy_ID = 'cno2w999' atau 'cno4w999'
        ==================== */
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
        /* ==================== 
        UNION 6: Khusus Marketing2ID = 'fahi999' atau '093975'
        - PIC_POS dipaksa fix '093975'
        - Periode data dibatasi antara 202408 - 202412
        ==================== */
        SELECT
            PIC_POS = '093975',
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
    /* ==================== 
    CTE RankedData: Pemberian Ranking
    - idxBY_LicensePlate → ranking per LicensePlate_fix + lokasi + AgreementNo + bulan lead
    - idxBY_LeadID → ranking per On_Boarding_Lead_ID + LicensePlate_fix + lokasi + AgreementNo + bulan lead
    - Ranking diprioritaskan berdasarkan status tertinggi (GoLive > Approval > Survey > Closing > Lead)
    ==================== */
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
    /* ==================== 
    Final Output:
    Ambil semua kolom dari RankedData
    (hasil gabungan BaseData dengan ranking per LicensePlate & per LeadID)
    ==================== */
SELECT
    *
FROM
    RankedData;
-- End of SQL script for Datamart_POS