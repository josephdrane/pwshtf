# pwshtf
Powershell Terraform

[![Build Status](https://travis-ci.org/josephdrane/pwshtf.svg?branch=master)](https://travis-ci.org/josephdrane/pwshtf)

## Problem Statement

We need a consistent and easy way to run terraform, from powershell, that abstracts away the complexities and provides a nice user experience for quickly getting new services spun up in a secure and standardized way.

## Goal

To generate terraform code based upon a powershell object configuration. There-by mapping a powershell object to a terraform template that is approved by the organization

## Disclaimer

My first time writing powershell classes. I tested this on a Mac and it works for me. 

## TODO : 

Needs code that extracts the zip file it downloads for terraform
Needs code that abstracts terraform config into an object
Needs the build server config setup to run on windows as well as MacOS
Needs unit tests for these areas.
Could use stronger typing on settings.
Core functionality of terraform template to objects needs to be done.