-- Create the analytical Trip view with financial reconciliation metrics

CREATE   VIEW dbo.vw_TripAnalytics
AS
SELECT
    t.DateID,
    t.MedallionID,
    t.HackneyLicenseID,
    t.PickupTimeID,
    t.DropoffTimeID,
    t.PickupGeographyID,
    t.DropoffGeographyID,
    t.PickupLatitude,
    t.PickupLongitude,
    t.PickupLatLong,
    t.DropoffLatitude,
    t.DropoffLongitude,
    t.DropoffLatLong,
    t.PassengerCount,
    t.TripDurationSeconds,
    t.TripDistanceMiles,
    t.PaymentType,
    t.FareAmount,
    t.SurchargeAmount,
    t.TaxAmount,
    t.TipAmount,
    t.TollsAmount,
    t.TotalAmount AS RecordedTotalAmount,

    CAST(
        t.FareAmount
        + t.SurchargeAmount
        + t.TaxAmount
        + t.TipAmount
        + t.TollsAmount
        AS decimal(18, 2)
    ) AS CalculatedTotalAmount,

    CAST(
        t.TotalAmount
        - (
            t.FareAmount
            + t.SurchargeAmount
            + t.TaxAmount
            + t.TipAmount
            + t.TollsAmount
        )
        AS decimal(18, 2)
    ) AS ReconciliationDifference,

    CASE
        WHEN ABS(
            t.TotalAmount
            - (
                t.FareAmount
                + t.SurchargeAmount
                + t.TaxAmount
                + t.TipAmount
                + t.TollsAmount
            )
        ) <= 0.01
        THEN 1
        ELSE 0
    END AS IsFinanciallyReconciled,

    CAST(
        t.TripDistanceMiles
        / NULLIF(CAST(t.TripDurationSeconds AS float) / 3600.0, 0)
        AS decimal(18, 2)
    ) AS AverageSpeedMph,

    CAST(
        t.TotalAmount / NULLIF(t.TripDistanceMiles, 0)
        AS decimal(18, 2)
    ) AS RevenuePerMile,

    CAST(
        t.TipAmount / NULLIF(t.FareAmount, 0)
        AS decimal(18, 4)
    ) AS TipRate
FROM dbo.Trip AS t;

GO