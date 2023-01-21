pragma solidity ^0.8.0;

contract FantasyBaseballScoring {
    // Enumeration for the different scoring categories
    enum ScoringCategory {
        Hitting,
        Pitching,
        Defense
    }

    // Enumeration for the different hitting statistics
    enum HittingStatistic {
        BattingAverage,
        HomeRuns,
        RunsBattedIn,
        RunsScored,
        StolenBases,
        OnBasePercentage,
        SluggingPercentage,
        TotalBases,
        Walks,
        Strikeouts,
        Doubles,
        Triples,
        Hits,
        GamesPlayed,
        AtBats,
        PlateAppearance,
        HitByPitch,
        Sacrifices,
        CaughtStealing,
        GroundIntoDoublePlay
    }

    // Enumeration for the different pitching statistics
    enum PitchingStatistic {
        EarnedRunAverage,
        Wins,
        Losses,
        Saves,
        InningsPitched,
        Strikeouts,
        Walks,
        HitsAllowed,
        HomeRunsAllowed,
        EarnedRuns,
        Whip,
        QualityStarts,
        Holds,
        BlownSaves,
        StrikeoutToWalkRatio,
        HitsPer9Innings,
        HomeRunsPer9Innings,
        WalksPer9Innings,
        StrikeoutsPer9Innings,
        GroundBallsPerFlyBalls,
        LeftOnBasePercentage
    }

    // Enumeration for the different defensive statistics
    enum DefenseStatistic {
        Putouts,
        Assists,
        Errors,
        FieldingPercentage,
        RangeFactor,
        ZoneRating,
        TotalChances,
        InningsPlayed,
        GamesPlayed,
        DoublePlays,
        PassedBalls,
        CatcherERA,
        StolenBasesAllowed,
        CaughtStealing,
        Pickoffs,
        CatcherPickoffs,
        CatcherStolenBasePercentage
    }

    // Mapping to store the weight of each scoring category
    mapping(ScoringCategory => uint256) public scoringWeights;

    // Mapping to store whether each scoring category is enabled
    mapping(ScoringCategory => bool) public scoringEnabled;

    // Mapping to store whether each hitting statistic is enabled
    mapping(HittingStatistic => bool) public hittingStatisticsEnabled;

    // Mapping to store whether each pitching statistic is enabled
    mapping(PitchingStatistic => bool) public pitchingStatisticsEnabled;

    // Mapping to store whether each defensive statistic is enabled
    mapping(DefenseStatistic => bool) public defenseStatisticsEnabled;

    // Event to log when a scoring category is updated
    event LogScoringCategoryUpdated(ScoringCategory category, uint256 weight, bool enabled);

    // Event to log when a hitting statistic is updated
    event LogHittingStatisticUpdated(HittingStatistic statistic, bool enabled);

    // Event to log when a pitching statistic is updated
    event LogPitchingStatisticUpdated(PitchingStatistic statistic, bool enabled);

    // Event to log when a defensive statistic is updated
    event LogDefenseStatisticUpdated(DefenseStatistic statistic, bool enabled);

    // Function to update the weight of a scoring category
    function updateScoringWeight(ScoringCategory _category, uint256 _weight) public {
        // Check that the scoring category is enabled
        require(scoringEnabled[_category] == true, "Scoring category is not enabled");

        // Update the weight of the scoring category
        scoringWeights[_category] = _weight;

        // Emit the LogScoringCategoryUpdated event
        emit LogScoringCategoryUpdated(_category, _weight, scoringEnabled[_category]);
    }

    // Function to update whether a scoring category is enabled
    function updateScoringEnabled(ScoringCategory _category, bool _enabled) public {
        // Update whether the scoring category is enabled
        scoringEnabled[_category] = _enabled;

        // Emit the LogScoringCategoryUpdated event
        emit LogScoringCategoryUpdated(_category, scoringWeights[_category], _enabled);
    }

    // Function to update whether a hitting statistic is enabled
    function updateHittingStatisticEnabled(HittingStatistic _statistic, bool _enabled) public {
        // Update whether the hitting statistic is enabled
        hittingStatisticsEnabled[_statistic] = _enabled;

        // Emit the LogHittingStatisticUpdated event
        emit LogHittingStatisticUpdated(_statistic, _enabled);
    }

    // Function to update whether a pitching statistic is enabled
    function updatePitchingStatisticEnabled(PitchingStatistic _statistic, bool _enabled) public {
        // Update whether the pitching statistic is enabled
        pitchingStatisticsEnabled[_statistic] = _enabled;

        // Emit the LogPitchingStatisticUpdated event
        emit LogPitchingStatisticUpdated(_statistic, _enabled);
    }

    // Function to update whether a defensive statistic is enabled
    function updateDefenseStatisticEnabled(DefenseStatistic _statistic, bool _enabled) public {
        // Update whether the defensive statistic is enabled
        defenseStatisticsEnabled = _enabled;

        // Emit the LogDefenseStatisticUpdated event
        emit LogDefenseStatisticUpdated(_statistic, _enabled);
    }
}


