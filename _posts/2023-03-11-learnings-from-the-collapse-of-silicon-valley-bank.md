---
title: Learnings from the collapse of the Silicon Valley Bank
date: 2023-03-11
desc: Silicon Valley Bank mismanaged risks, announced sale of securities at a loss to meet withdrawal obligations, majority-depositors were VCs in the tech and healthcare industry who were shrewd to act optimally (in a game-theoretic sense), spread the word through network-effects, led to  'bankrun', FDIC took-over and placed under receivership, posed systemic risk, the feds, treasury, and FDIC intervened to make the depositors whole. What can we learn from this? 
keywords: finance, banking, silicon valley bank, bankrun, fdic, treasury, feds, depositors, deposit insurance, ban
categories: blog
tags: finance, mbs, tresury, fdic, sipc, venture debt, venture risk management
icon: fa-book
---

Cash is King but when the Castle (Bank) becomes unsafe, where does the King go?

**TLDR:** Silicon Valley Bank mismanaged risks, announced sale of securities at a loss to meet withdrawal obligations, majority-depositors were VCs and their portfolio companies in the tech and healthcare industry who were shrewd to act optimally (in a game-theoretic sense), spread the word through network-effects, led to  'bankrun', FDIC took-over and placed under receivership, posed systemic risk, the feds, treasury, and FDIC intervened to make the depositors whole. What can we learn from this? 

## What happend to Silicon Valley Bank?
Silicon Valley Bank (SVB) is (was) U.S's 16th largest Bank with assets totaling $220 Billion. What can go wrong in less than a week?

* **Wednesday, March 8th, 2023**: SVB sold approximately $21 billion of its portfolio consisting mostly of U.S. Treasuries. The portfolio was yielding it an average 1.79%, far below the current 10-year Treasury yield of around 3.9%, resulting in an accounting loss of approximately $1.8 billion.
* **Thursday, March 9th, 2023**: Bankrun starts. Several clients including Founders fund withdrew deposits and advised their portfolio companies to do the same. SVB's stock price dropped 60%. SVB announced it's plan to sell $2.25 Billion in common equity and preferred convertible stock to fill its funding hole. SVB's publicly traded stock ($SVIB) Shares down 60%., which it needed to fill through a capital raise. 
* **Friday, March 10th, 2023**: SVB scrambled to find alternative funding but couldn't in a short span. FDIC shut the bank down and placed under receivership.
* **Saturday, March 11th, 2023**: Chaos.
* **Sunday, March 12th, 2023**: A [joint statement from the U.S Treasury secretary, Federal Reserve Board Chair and FDIC Chairman on Sunday, 03-12-2023](https://www.federalreserve.gov/newsevents/pressreleases/monetary20230312b.htm) evening said all depositors will have access to their funds on Monday, March 13, and that "no losses associated with the resolution of Silicon Valley Bank will be borne by the taxpayer."
* **Monday, March 13th, 2023**: Relief. Depositors can access their funds.

## Learnings from the collapse of Silicon Valley Bank

- SVB is the bank of choice for most if not ALL startups, VCs and others (including small tech) companies.
- SVB had to sell securities on 3/8 to raise money to meet its short-term liquidity needs since it had majority of it's holdings in Bonds(MBS & U.S Treasuries) with long-term maturity dates.
- When the customers lost trust in the Bank's ability to operate as a "bank" as in, withdraw money from the customer's own deposited and avilable account balance, a new dynamics/game was induced wherein the optimal (in a game-theoretic sense) strategy was to withdraw all the money ASAP before everybody else does and the bank becomes illiquid.
- Was this panic/fear-driven market dynamics/game necessary? No but, if the highly-regulated Bank fails on it's basic obligations and induces unaccounted risk, it became inevitable.

- Insured cash Deposits vs Uninsured cash deposits at the Banks
   - FDIC insures upto 250k/person /bank account
   - If your personal or company's cash balance on one Bank account increases beyond $250k, to better manage risk, you would want to transfer/sweep that excess cash beyond $250 manually to an account at a different bank.
    - But, why would someone have to track and do this monotonous task? Aren't there many financial institutions which automatically sweeps the balances to multiple banks to take care of this?
     - Yes, even SVB had cash deposit sweep programs at Blackrock & MS. But they are not held in accounts on your name that you can access or avail FDIC insurance coverage directly on.
    - There are only 4 "big" banks though
    -  
- If you or your company has more than 250k in cash, given today's FDIC insurance limits of 250k per person/company per bank, 

## Where does the cash from SVB go?

So, where does the king go? The fund outflows could go to:
1. U.S Treasury Bonds
2. Mortgage-backed Securities
3. Money Market Accounts or to other insured deposit accounts at the Big banks (JPMC, BofA, WF, Citi)
4. Brokerage Accounts which are backed by SIPC (upto 1.2M) 

## Private Depositors at Silicon Valley Bank
Source: DiligenceExpress; extracted from SEC Form ADV filings. Information is 
presented "as is", with no liability as to errors in data extraction or underlying filings.
Contributed by Jacob Silverman, Independent Journalist.

<div id="grid"></div>

<!-- import and parse CSV file data supplied via include parameter csvDataFile, display in a XL like DataGrid -->
<style>
    #grid {
      height: 85%;
    }
</style>
    

<!-- Papa Parse (to import and parse CSV files) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/PapaParse/5.3.1/papaparse.min.js"></script>


<script src="https://cdn.jsdelivr.net/npm/gridjs/dist/gridjs.umd.js"></script>
<link href="https://cdn.jsdelivr.net/npm/gridjs/dist/theme/mermaid.min.css" rel="stylesheet" />

<script>
    Papa.parse("/static/assets/data/svb-depositors.csv", {
        download: true,
        header: true,
        dynamicTyping: true,
        complete: function(results) {
            grid = new gridjs.Grid({
                data: results.data,
                pagination: {
                    limit: 10
                },
                search: true,
                sort: true,
            }).render(document.getElementById("grid"));
        }
    });
</script>