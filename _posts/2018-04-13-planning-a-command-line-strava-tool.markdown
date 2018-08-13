---
layout: post
title:  "Planning a command-line Strava tool"
date:   2018-04-13
categories: blog
---

(Updated August 12, 2018)

Strava is great, and I generally like how it presents my activities to me, but the data it stores could be presented in many other ways as well. I've registered a new project with Strava Apps, hoping to get at my raw activity data for some further analysis. Not knowing exactly what I wanted to do with it, I left my app description very general: "Advanced statistics and performance metrics for personal use".

## Goals

What am I looking for? One thing that bothers me about Strava is the weak divide between activity types. I can go into my Training Log and filter by sport, but I find it hard to get a sense of the numbers and trends from this view. From my profile I can see my weekly total activity distance for the past year, but this view is of limited use to me since biking is weighted so heavily.

<img src="/assets/strava-weekly-view.gif" alt="Strava's weekly view" style="width: 100%">

I biked a lot the first week of June, and it dominates the view. I will look into ignoring non-running data and giving a more informative weekly breakdown, maybe with an average speed, fastest/slowest run and longest/shortest run. I've opted for a CLI solution to get more familiar with command line parsing.

## Prototype

So far my Java prototype only gives me a list of activities for a specified date range. The output from `$ java -jar strava-stats-1.0-SNAPSHOT-jar-with-dependencies.jar list -start 2018-04-012 -end 2018-04-13` shows a recent run:

```
class SummaryActivity {
    id: 1505241227
    externalId: garmin_push_2620191724
    uploadId: 1620934653
    athlete: class MetaAthlete {
        id: 19307941
    }
    name: Afternoon Run
    distance: 7998.3
    movingTime: 2179
    elapsedTime: 2407
    totalElevationGain: 85.3
    elevHigh: 115.0
    elevLow: 80.4
    type: Run
    startDate: 2018-04-13T00:27:17Z
    startDateLocal: 2018-04-12T17:27:17Z
    timezone: (GMT-08:00) America/Vancouver
    startLatlng: class LatLng {
        [49.26, -123.22]
    }
    endLatlng: class LatLng {
        [49.26, -123.22]
    }
    achievementCount: 3
    kudosCount: 1
    commentCount: 0
    athleteCount: 2
    photoCount: 0
    totalPhotoCount: 0
    map: class PolylineMap {
        id: a1505241227
        polyline: null
        summaryPolyline: yytkHlm`oVt_@h@g@j}@Bkx@}BoBcZe@z@|_BkCrNsGjIqFzNcAjUbBlP}KfI_\hHUse@|Eyi@vIw^v[yz@pAkXv@lBfBiB
    }
    trainer: false
    commute: false
    manual: false
    _private: false
    flagged: false
    workoutType: null
    averageSpeed: 3.671
    maxSpeed: 5.3
    hasKudoed: false
}
```

This gives me my distance, elapsed time, and elevation gain which I already knew from the UI, but adds on some extra data such as averageSpeed (in m/s unfortunately, instead of s/km or min/km) and maxSpeed. I found it interesting how the route line is encoded in a long String. 

I'll keep playing with the data and find a way to present it.