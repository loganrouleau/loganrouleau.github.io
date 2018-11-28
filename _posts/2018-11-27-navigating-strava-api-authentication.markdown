---
layout: post
title:  "Navigating Strava API Authentication"
date:   2018-11-27
categories: blog
---

On October 15, 2018 Strava made a small change to their [API authentication flow](https://developers.strava.com/docs/authentication/). Changes included removal of permanent access tokens (effective Oct. 2019), and improvements to the documentation. Having struggled to understand the previous version of Strava's OAuth2 implementation, I thought I would walk through the new process required to obtain an access token. 

This post will be language agnostic - I'll use Postman and my browser to make the required HTTP calls. The intent is to help with integrating the process into a Strava app by giving a concrete example of how to do it.

## 1. Request Access

After setting up your app, in Settings - My API Application you will find your Client ID, Client Secret, and the redirect uri you've specified to handle Strava's callback.

Send a GET request with the required fields.

<img src="/assets/strava-auth-1.jpg" style="width: 100%">

If you don't actually have a server listening for the callback yet, you can paste the request into your browser and see the code returned. First, you (or your eventual app user) will have to log in and allow access to the app.

<img src="/assets/strava-auth-2.jpg" style="width: 80%">

Once approved, Strava will call you on your configured redirect uri with a code. My browser tried (and failed, as expected) to redirect me to  `https://localhost:8081/?state=&code=bf6d51fefd1ad7dc0b4b58d41dffa6aed1c77b70&scope=read,activity:read_all`.

## 2. Token Exchange

Send a POST with the code you obtained in Step 1.

<img src="/assets/strava-auth-3.jpg" style="width: 100%">

You're done! The access token provided is valid for 6 hours, and can be used immediately to access the API. Remember that Authorization: Bearer [[token]] is an HTTP Header, not a query parameter.

<img src="/assets/strava-auth-4.jpg" style="width: 100%">

## 3. Refreshing a Token

If you need to refresh a token, a POST request similar to the one in the previous step is used.

The main differences are changing the `grant_type` value to `refresh_token` and using the refresh token you were given in Step 2 in place of the code parameter.

<img src="/assets/strava-auth-5.jpg" style="width: 100%">

Since I did this only a few minutes after obtaining my token, I received the same access token in this step. Note that the `expires_in` field has changed.