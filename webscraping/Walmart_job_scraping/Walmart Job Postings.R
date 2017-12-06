library(XML)
library(rvest)
library(RCurl)
library(xlsx)
library(stringr)
library(tidyr)
library(urltools)
library(dplyr)
library(plotly)

url <- "https://careers.walmart.com/results?q=data&o=475&sort=rank&jobCategory=all"
url2 <- getURL(url)
parsed <- htmlParse(url2)
links <- xpathSApply(parsed,path = "//h4",xmlGetAttr,"href")

parsed

links
url2

link1 <- "https://careers.walmart.com/us/jobs/883210BR-data-scientist-sunnyvale-ca"
web1 <- read_html(link1)
job1 <- web1 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview1 <- web1 %>%
        html_node(".job-description__overview") %>%
        html_text()

link2 <- "https://careers.walmart.com/us/jobs/956279BR-senior-platform-engineer-predictive-analytics-platform-sunnyvale-ca"
web2 <- read_html(link2)
job2 <- web2 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview2 <- web2 %>%
        html_node(".job-description__overview") %>%
        html_text()

link3 <- "https://careers.walmart.com/us/jobs/890286BR-programmer-analyst-isd-web-developer-bentonville-ar"
web3 <- read_html(link3)
job3 <- web3 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview3 <- web3 %>%
        html_node(".job-description__overview") %>%
        html_text()

link4 <- "https://careers.walmart.com/us/jobs/880516BR-systems-analyst-isd-bentonville-ar"
web4 <- read_html(link4)
job4 <- web4 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview4 <- web4 %>%
        html_node(".job-description__overview") %>%
        html_text()

link5 <- "https://careers.walmart.com/us/jobs/886329BR-senior-programmer-analyst-isd-bentonville-ar"
web5 <- read_html(link5)
job5 <- web5 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview5 <- web5 %>%
        html_node(".job-description__overview") %>%
        html_text()

link6 <- "https://careers.walmart.com/us/jobs/861709BR-programmer-analyst-isd-bentonville-ar"
web6 <- read_html(link6)
job6 <- web6 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview6 <- web6 %>%
        html_node(".job-description__overview") %>%
        html_text()

link7 <- "https://careers.walmart.com/us/jobs/868985BR-developer-i-isd-east-reston-va"
web7 <- read_html(link7)
job7 <- web7 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview7 <- web7 %>%
        html_node(".job-description__overview") %>%
        html_text()

link8 <- "https://careers.walmart.com/us/jobs/870385BR-developer-ii-isd-east-reston-va"
web8 <- read_html(link8)
job8 <- web8 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview8 <- web8 %>%
        html_node(".job-description__overview") %>%
        html_text()

link9 <- "https://careers.walmart.com/us/jobs/863207BR-quality-engineering-expert-bentonville-ar"
web9 <- read_html(link9)
job9 <- web9 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview9 <- web9 %>%
        html_node(".job-description__overview") %>%
        html_text()

link10 <- "https://careers.walmart.com/us/jobs/877723BR-technical-expert-isd-bentonville-ar"
web10 <- read_html(link10)
job10 <- web10 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview10 <- web10 %>%
        html_node(".job-description__overview") %>%
        html_text()

link11 <- "https://careers.walmart.com/us/jobs/878951BR-programmer-isd-bentonville-ar"
web11 <- read_html(link11)
job11 <- web11 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview11 <- web11 %>%
        html_node(".job-description__overview") %>%
        html_text()

link12 <- "https://careers.walmart.com/us/jobs/822826BR-staff-devops-engineer-sunnyvale-ca"
web12 <- read_html(link12)
job12 <- web12 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview12 <- web12 %>%
        html_node(".job-description__overview") %>%
        html_text()

link13 <- "https://careers.walmart.com/us/jobs/847283BR-developer-ii-isd-east-reston-va"
web13 <- read_html(link13)
job13 <- web13 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview13 <- web13 %>%
        html_node(".job-description__overview") %>%
        html_text()

link14 <- "https://careers.walmart.com/us/jobs/851220BR-programmer-analyst-isd-net-bentonville-ar"
web14 <- read_html(link14)
job14 <- web14 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview14 <- web14 %>%
        html_node(".job-description__overview") %>%
        html_text()

link15 <- "https://careers.walmart.com/us/jobs/859852BR-senior-software-engineer-front-end-sunnyvale-ca"
web15 <- read_html(link15)
job15 <- web15 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview15 <- web15 %>%
        html_node(".job-description__overview") %>%
        html_text()

link16 <- "https://careers.walmart.com/us/jobs/852605BR-senior-programmer-analyst-isd-full-stack-bentonville-ar"
web16 <- read_html(link16)
job16 <- web16 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview16 <- web16 %>%
        html_node(".job-description__overview") %>%
        html_text()

link17 <- "https://careers.walmart.com/us/jobs/956279BR-senior-platform-engineer-predictive-analytics-platform-sunnyvale-ca"
web17 <- read_html(link17)
job17 <- web17 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview17 <- web17 %>%
        html_node(".job-description__overview") %>%
        html_text()

link18 <- "https://careers.walmart.com/us/jobs/932109BR-data-analyst-sunnyvale-ca"
web18 <- read_html(link18)
job18 <- web18 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview18 <- web18 %>%
        html_node(".job-description__overview") %>%
        html_text()

link19 <- "https://careers.walmart.com/us/jobs/949505BR-senior-data-analyst-san-bruno-ca"
web19 <- read_html(link19)
job19 <- web19 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview19 <- web19 %>%
        html_node(".job-description__overview") %>%
        html_text()

link20 <- "https://careers.walmart.com/us/jobs/944402BR-senior-statistical-analyst-data-analytics-sunnyvale-ca"
web20 <- read_html(link20)
job20 <- web20 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview20 <- web20 %>%
        html_node(".job-description__overview") %>%
        html_text()

link21 <- "https://careers.walmart.com/us/jobs/877573BR-senior-programmer-analyst-isd-big-data-bentonville-ar"
web21 <- read_html(link21)
job21 <- web21 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview21 <- web21 %>%
        html_node(".job-description__overview") %>%
        html_text()

link22 <- "https://careers.walmart.com/us/jobs/946527BR-manager-data-analytics-bentonville-ar"
web22 <- read_html(link22)
job22 <- web22 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview22 <- web22 %>%
        html_node(".job-description__overview") %>%
        html_text()

link23 <- "https://careers.walmart.com/us/jobs/867762BR-senior-programmer-analyst-isd-big-data-hadoop-bentonville-ar"
web23 <- read_html(link23)
job23 <- web23 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview23 <- web23 %>%
        html_node(".job-description__overview") %>%
        html_text()

link24 <- "https://careers.walmart.com/us/jobs/868950BR-director-retail-data-science-bentonville-ar"
web24 <- read_html(link24)
job24 <- web24 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview24 <- web24 %>%
        html_node(".job-description__overview") %>%
        html_text()

link25 <- "https://careers.walmart.com/us/jobs/924791BR-data-scientist-san-bruno-ca"
web25 <- read_html(link25)
job25 <- web25 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview25 <- web25 %>%
        html_node(".job-description__overview") %>%
        html_text()

link26 <- "https://careers.walmart.com/us/jobs/886678BR-systems-analyst-analytics-isd-hadoop-big-data-bentonville-ar"
web26 <- read_html(link26)
job26 <- web26 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview26 <- web26 %>%
        html_node(".job-description__overview") %>%
        html_text()

link27 <- "https://careers.walmart.com/us/jobs/875213BR-principal-data-scientist-sunnyvale-ca"
web27 <- read_html(link27)
job27 <- web27 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview27 <- web27 %>%
        html_node(".job-description__overview") %>%
        html_text()

link28 <- "https://careers.walmart.com/us/jobs/872692BR-data-assurance-analyst-iii-bentonville-ar"
web28 <- read_html(link28)
job28 <- web28 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview28 <- web28 %>%
        html_node(".job-description__overview") %>%
        html_text()

link29 <- "https://careers.walmart.com/us/jobs/879217BR-staff-data-scientist-san-bruno-ca"
web29 <- read_html(link29)
job29 <- web29 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview29 <- web29 %>%
        html_node(".job-description__overview") %>%
        html_text()

link30 <- "https://careers.walmart.com/us/jobs/840811BR-distinguished-data-scientist-san-bruno-ca"
web30 <- read_html(link30)
job30 <- web30 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview30 <- web30 %>%
        html_node(".job-description__overview") %>%
        html_text()

link31 <- "https://careers.walmart.com/us/jobs/890961BR-senior-data-scientist-bentonville-ar"
web31 <- read_html(link31)
job31 <- web31 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview31 <- web31 %>%
        html_node(".job-description__overview") %>%
        html_text()

link32 <- "https://careers.walmart.com/us/jobs/872453BR-machine-learning-data-scientist-sunnyvale-ca"
web32 <- read_html(link32)
job32 <- web32 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview32 <- web32 %>%
        html_node(".job-description__overview") %>%
        html_text()

link33 <- "https://careers.walmart.com/us/jobs/905893BR-data-scientist-search-team-sunnyvale-ca"
web33 <- read_html(link33)
job33 <- web33 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview33 <- web33 %>%
        html_node(".job-description__overview") %>%
        html_text()

link34 <- "https://careers.walmart.com/us/jobs/851630BR-data-scientist-isd-bentonville-ar"
web34 <- read_html(link34)
job34 <- web34 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview34 <- web34 %>%
        html_node(".job-description__overview") %>%
        html_text()

link35 <- "https://careers.walmart.com/us/jobs/872770BR-data-assurance-researcher-cybersecurity-wmtech-bentonville-ar"
web35 <- read_html(link35)
job35 <- web35 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview35 <- web35 %>%
        html_node(".job-description__overview") %>%
        html_text()

link36 <- "https://careers.walmart.com/us/jobs/870437BR-data-assurance-analyst-iii-cybersecurity-wmtech-bentonville-ar"
web36 <- read_html(link36)
job36 <- web36 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview36 <- web36 %>%
        html_node(".job-description__overview") %>%
        html_text()

link37 <- "https://careers.walmart.com/us/jobs/867746BR-associate-data-scientist-isd-bentonville-ar"
web37 <- read_html(link37)
job37 <- web37 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview37 <- web37 %>%
        html_node(".job-description__overview") %>%
        html_text()

link38 <- "https://careers.walmart.com/us/jobs/835513BR-associate-data-scientist-machine-learning-austin-tx"
web38 <- read_html(link38)
job38 <- web38 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview38 <- web38 %>%
        html_node(".job-description__overview") %>%
        html_text()

link39 <- "https://careers.walmart.com/us/jobs/931213BR-principal-software-engineer-big-data-systems-sunnyvale-ca"
web39 <- read_html(link39)
job39 <- web39 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview39 <- web39 %>%
        html_node(".job-description__overview") %>%
        html_text()

link40 <- "https://careers.walmart.com/us/jobs/912902BR-senior-big-data-tools-engineer-sunnyvale-ca"
web40 <- read_html(link40)
job40 <- web40 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview40 <- web40 %>%
        html_node(".job-description__overview") %>%
        html_text()

link41 <- "https://careers.walmart.com/us/jobs/933905BR-sr-director-retail-data-science-san-bruno-ca"
web41 <- read_html(link41)
job41 <- web41 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview41 <- web41 %>%
        html_node(".job-description__overview") %>%
        html_text()

link42 <- "https://careers.walmart.com/us/jobs/875199BR-staff-data-scientist-anti-fraud-sunnyvale-ca"
web42 <- read_html(link42)
job42 <- web42 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview42 <- web42 %>%
        html_node(".job-description__overview") %>%
        html_text()

link43 <- "https://careers.walmart.com/us/jobs/908651BR-senior-software-engineer-search-big-data-sunnyvale-ca"
web43 <- read_html(link43)
job43 <- web43 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview43 <- web43 %>%
        html_node(".job-description__overview") %>%
        html_text()

link44 <- "https://careers.walmart.com/us/jobs/827039BR-sr-statistic-analyst-data-analytics-isd-bentonville-ar"
web44 <- read_html(link44)
job44 <- web44 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview44 <- web44 %>%
        html_node(".job-description__overview") %>%
        html_text()

link45 <- "https://careers.walmart.com/us/jobs/868987BR-statistical-analyst-bentonville-ar"
web45 <- read_html(link45)
job45 <- web45 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview45 <- web45 %>%
        html_node(".job-description__overview") %>%
        html_text()

link46 <- "https://careers.walmart.com/us/jobs/905876BR-software-engineer-iii-big-data-machine-learning-sunnyvale-ca"
web46 <- read_html(link46)
job46 <- web46 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview46 <- web46 %>%
        html_node(".job-description__overview") %>%
        html_text()

link47 <- "https://careers.walmart.com/us/jobs/891658BR-advanced-systems-engineer-data-center-isd-bentonville-ar"
web47 <- read_html(link47)
job47 <- web47 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview47 <- web47 %>%
        html_node(".job-description__overview") %>%
        html_text()

link48 <- "https://careers.walmart.com/us/jobs/936597BR-senior-manager-customer-analytics-global-insights-san-bruno-ca"
web48 <- read_html(link48)
job48 <- web48 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview48 <- web48 %>%
        html_node(".job-description__overview") %>%
        html_text()

link49 <- "https://careers.walmart.com/us/jobs/930990BR-2018-summer-internship-central-operations-data-scientist-bentonville-ar"
web49 <- read_html(link49)
job49 <- web49 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview49 <- web49 %>%
        html_node(".job-description__overview") %>%
        html_text()

link50 <- "https://careers.walmart.com/us/jobs/872239BR-sr-manager-analytics-and-reporting-global-audits-bentonville-ar"
web50 <- read_html(link50)
job50 <- web50 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview50 <- web50 %>%
        html_node(".job-description__overview") %>%
        html_text()

link51 <- "https://careers.walmart.com/us/jobs/905876BR-software-engineer-iii-big-data-machine-learning-sunnyvale-ca"
web51 <- read_html(link51)
job51 <- web51 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview51 <- web51 %>%
        html_node(".job-description__overview") %>%
        html_text()

link52 <- "https://careers.walmart.com/us/jobs/921007BR-sr-data-analyst-vudu-sunnyvale-ca"
web52 <- read_html(link52)
job52 <- web52 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview52 <- web52 %>%
        html_node(".job-description__overview") %>%
        html_text()

link53 <- "https://careers.walmart.com/us/jobs/918188BR-senior-taxonomist-structured-data-ho-wec-wmtech-bentonville-ar"
web53 <- read_html(link53)
job53 <- web53 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview53 <- web53 %>%
        html_node(".job-description__overview") %>%
        html_text()

link54 <- "https://careers.walmart.com/us/jobs/679949BR-planner-travel-sourcing-and-analytics-walmart-global-travel-bentonville-ar"
web54 <- read_html(link54)
job54 <- web54 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview54 <- web54 %>%
        html_node(".job-description__overview") %>%
        html_text()

link55 <- "https://careers.walmart.com/us/jobs/900679BR-2018-full-time-gp-programmer-analyst-data-platforms-bentonville-ar"
web55 <- read_html(link55)
job55 <- web55 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview55 <- web55 %>%
        html_node(".job-description__overview") %>%
        html_text()

link56 <- "https://careers.walmart.com/us/jobs/905434BR-2018-full-time-gbs-programmer-analyst-data-strategy-coe-bentonville-ar"
web56 <- read_html(link56)
job56 <- web56 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview56 <- web56 %>%
        html_node(".job-description__overview") %>%
        html_text()

link57 <- "https://careers.walmart.com/us/jobs/939609BR-director-engineering-sunnyvale-ca"
web57 <- read_html(link57)
job57 <- web57 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview57 <- web57 %>%
        html_node(".job-description__overview") %>%
        html_text()

link58 <- "https://careers.walmart.com/us/jobs/802632BR-operations-analyst-cross-border-san-bruno-ca"
web58 <- read_html(link58)
job58 <- web58 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview58 <- web58 %>%
        html_node(".job-description__overview") %>%
        html_text()

link59 <- "https://careers.walmart.com/us/jobs/879027BR-technical-product-manager-sunnyvale-ca"
web59 <- read_html(link59)
job59 <- web59 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview59 <- web59 %>%
        html_node(".job-description__overview") %>%
        html_text()

link60 <- "https://careers.walmart.com/us/jobs/938097BR-staff-software-engineer-sunnyvale-ca"
web60 <- read_html(link60)
job60 <- web60 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview60 <- web60 %>%
        html_node(".job-description__overview") %>%
        html_text()

link61 <- "https://careers.walmart.com/us/jobs/888388BR-senior-manager-ii-digital-experience-roadmap-san-bruno-ca"
web61 <- read_html(link61)
job61 <- web61 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview61 <- web61 %>%
        html_node(".job-description__overview") %>%
        html_text()

link62 <- "https://careers.walmart.com/us/jobs/926439BR-temporary-support-specialist-billing-recoveries-bentonville-ar"
web62 <- read_html(link62)
job62 <- web62 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview62 <- web62 %>%
        html_node(".job-description__overview") %>%
        html_text()

link63 <- "https://careers.walmart.com/us/jobs/888294BR-sr-software-engineer-cybersec-wmtech-bentonville-ar"
web63 <- read_html(link63)
job63 <- web63 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview63 <- web63 %>%
        html_node(".job-description__overview") %>%
        html_text()

link64 <- "https://careers.walmart.com/us/jobs/873254BR-manager-analytics-and-planning-san-bruno-ca"
web64 <- read_html(link64)
job64 <- web64 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview64 <- web64 %>%
        html_node(".job-description__overview") %>%
        html_text()

link65 <- "https://careers.walmart.com/us/jobs/950541BR-temp-services-e-bentonville-ar"
web65 <- read_html(link65)
job65 <- web65 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview65 <- web65 %>%
        html_node(".job-description__overview") %>%
        html_text()

link66 <- "https://careers.walmart.com//us/jobs/950544BR-temporary-specialist-iii-bentonville-ar"
web66 <- read_html(link66)
job66 <- web66 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview66 <- web66 %>%
        html_node(".job-description__overview") %>%
        html_text()

link67 <- "https://careers.walmart.com/us/jobs/900723BR-2018-full-time-sams-technology-sr-statistical-analyst-bentonville-ar"
web67 <- read_html(link67)
job67 <- web67 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview67 <- web67 %>%
        html_node(".job-description__overview") %>%
        html_text()

link68 <- "https://careers.walmart.com/us/jobs/900224BR-2018-full-time-gp-sr-statistical-analyst-retail-analytics-bentonville-ar"
web68 <- read_html(link68)
job68 <- web68 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview68 <- web68 %>%
        html_node(".job-description__overview") %>%
        html_text()

link69 <- "https://careers.walmart.com/us/jobs/807093BR-supply-chain-associate-san-bruno-ca"
web69 <- read_html(link69)
job69 <- web69 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview69 <- web69 %>%
        html_node(".job-description__overview") %>%
        html_text()

link70 <- "https://careers.walmart.com/us/jobs/825219BR-senior-manager-customer-analytics-vudu-sunnyvale-ca"
web70 <- read_html(link70)
job70 <- web70 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview70 <- web70 %>%
        html_node(".job-description__overview") %>%
        html_text()

link71 <- "https://careers.walmart.com/us/jobs/936492BR-temporary-specialist-iv-bentonville-ar"
web71 <- read_html(link71)
job71 <- web71 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview71 <- web71 %>%
        html_node(".job-description__overview") %>%
        html_text()

link72 <- "https://careers.walmart.com/us/jobs/943232BR-product-manager-grocery-analytics-san-bruno-ca"
web72 <- read_html(link72)
job72 <- web72 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview72 <- web72 %>%
        html_node(".job-description__overview") %>%
        html_text()

link73 <- "https://careers.walmart.com/us/jobs/837180BR-manager-business-analytics-insights-san-bruno-ca"
web73 <- read_html(link73)
job73 <- web73 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview73 <- web73 %>%
        html_node(".job-description__overview") %>%
        html_text()

link74 <- "https://careers.walmart.com/us/jobs/922104BR-associate-manager-new-customer-propositions-ecomm-ops-san-bruno-ca"
web74 <- read_html(link74)
job74 <- web74 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview74 <- web74 %>%
        html_node(".job-description__overview") %>%
        html_text()

link75 <- "https://careers.walmart.com/us/jobs/947800BR-principal-software-engineer-database-devops-carlsbad-ca"
web75 <- read_html(link75)
job75 <- web75 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview75 <- web75 %>%
        html_node(".job-description__overview") %>%
        html_text()

link76 <- "https://careers.walmart.com/us/jobs/950082BR-director-product-management-product-partnerships-growth-san-bruno-ca"
web76 <- read_html(link76)
job76 <- web76 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview76 <- web76 %>%
        html_node(".job-description__overview") %>%
        html_text()

link77 <- "https://careers.walmart.com/us/jobs/834624BR-senior-manager-site-analytics-san-bruno-ca"
web77 <- read_html(link77)
job77 <- web77 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview77 <- web77 %>%
        html_node(".job-description__overview") %>%
        html_text()

link78 <- "https://careers.walmart.com/us/jobs/885370BR-analyst-ii-analytics-forensics-audit-finance-bentonville-ar"
web78 <- read_html(link78)
job78 <- web78 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview78 <- web78 %>%
        html_node(".job-description__overview") %>%
        html_text()

link79 <- "https://careers.walmart.com/us/jobs/858618BR-principal-platform-engineer-predictive-analytics-platform-sunnyvale-ca"
web79 <- read_html(link79)
job79 <- web79 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview79 <- web79 %>%
        html_node(".job-description__overview") %>%
        html_text()

link80 <- "https://careers.walmart.com/us/jobs/827398BR-staff-platform-engineer-predictive-analytics-platform-sunnyvale-ca"
web80 <- read_html(link80)
job80 <- web80 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview80 <- web80 %>%
        html_node(".job-description__overview") %>%
        html_text()

link81 <- "https://careers.walmart.com/us/jobs/943063BR-temporary-cash-application-specialist-bentonville-ar"
web81 <- read_html(link81)
job81 <- web81 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview81 <- web81 %>%
        html_node(".job-description__overview") %>%
        html_text()

link82 <- "https://careers.walmart.com/us/jobs/930891BR-temporary-specialist-iv-global-business-services-bentonville-ar"
web82 <- read_html(link82)
job82 <- web82 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview82 <- web82 %>%
        html_node(".job-description__overview") %>%
        html_text()

link83 <- "https://careers.walmart.com/us/jobs/884132BR-senior-manager-category-analytics-home-san-bruno-ca"
web83 <- read_html(link83)
job83 <- web83 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview83 <- web83 %>%
        html_node(".job-description__overview") %>%
        html_text()

link84 <- "https://careers.walmart.com/us/jobs/884135BR-senior-manager-category-analytics-entertainment-san-bruno-ca"
web84 <- read_html(link84)
job84 <- web84 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview84 <- web84 %>%
        html_node(".job-description__overview") %>%
        html_text()

link85 <- "https://careers.walmart.com/us/jobs/934776BR-compensation-analyst-hr-bentonville-ar"
web85 <- read_html(link85)
job85 <- web85 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview85 <- web85 %>%
        html_node(".job-description__overview") %>%
        html_text()

link86 <- "https://careers.walmart.com/us/jobs/904202BR-associate-product-manager-san-bruno-ca"
web86 <- read_html(link86)
job86 <- web86 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview86 <- web86 %>%
        html_node(".job-description__overview") %>%
        html_text()

link87 <- "https://careers.walmart.com/us/jobs/874264BR-senior-manager-partnership-analytics-reporting-san-bruno-ca"
web87 <- read_html(link87)
job87 <- web87 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview87 <- web87 %>%
        html_node(".job-description__overview") %>%
        html_text()

link88 <- "https://careers.walmart.com/us/jobs/894750BR-senior-software-engineer-java-node-js-sunnyvale-ca"
web88 <- read_html(link88)
job88 <- web88 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview88 <- web88 %>%
        html_node(".job-description__overview") %>%
        html_text()

link89 <- "https://careers.walmart.com/us/jobs/880158BR-full-stack-staff-software-engineer-behavioral-telemetry-sunnyvale-ca"
web89 <- read_html(link89)
job89 <- web89 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview89 <- web89 %>%
        html_node(".job-description__overview") %>%
        html_text()

link90 <- "https://careers.walmart.com/us/jobs/921595BR-project-manager-workforce-management-temporary-bentonville-ar"
web90 <- read_html(link90)
job90 <- web90 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview90 <- web90 %>%
        html_node(".job-description__overview") %>%
        html_text()

link91 <- "https://careers.walmart.com/us/jobs/945981BR-associate-product-manager-pickup-analytics-san-bruno-ca"
web91 <- read_html(link91)
job91 <- web91 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview91 <- web91 %>%
        html_node(".job-description__overview") %>%
        html_text()

link92 <- "https://careers.walmart.com/us/jobs/809763BR-supply-chain-associate-san-bruno-ca"
web92 <- read_html(link92)
job92 <- web92 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview92 <- web92 %>%
        html_node(".job-description__overview") %>%
        html_text()

link93 <- "https://careers.walmart.com/us/jobs/941423BR-temporary-cad-specialist-bentonville-ar"
web93 <- read_html(link93)
job93 <- web93 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview93 <- web93 %>%
        html_node(".job-description__overview") %>%
        html_text()

link94 <- "https://careers.walmart.com/us/jobs/931000BR-2018-summer-internship-human-resources-selection-assessment-bentonville-ar"
web94 <- read_html(link94)
job94 <- web94 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview94 <- web94 %>%
        html_node(".job-description__overview") %>%
        html_text()

link95 <- "https://careers.walmart.com/us/jobs/935067BR-senior-ios-engineer-sunnyvale-ca"
web95 <- read_html(link95)
job95 <- web95 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview95 <- web95 %>%
        html_node(".job-description__overview") %>%
        html_text()

link96 <- "https://careers.walmart.com/us/jobs/920751BR-senior-manager-cost-analytics-san-bruno-ca"
web96 <- read_html(link96)
job96 <- web96 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview96 <- web96 %>%
        html_node(".job-description__overview") %>%
        html_text()

link97 <- "https://careers.walmart.com/us/jobs/879666BR-senior-analyst-finance-business-systems-san-bruno-ca"
web97 <- read_html(link97)
job97 <- web97 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview97 <- web97 %>%
        html_node(".job-description__overview") %>%
        html_text()

link98 <- "https://careers.walmart.com/us/jobs/852829BR-senior-manager-strategy-san-bruno-ca"
web98 <- read_html(link98)
job98 <- web98 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview98 <- web98 %>%
        html_node(".job-description__overview") %>%
        html_text()

link99 <- "https://careers.walmart.com/us/jobs/935138BR-associate-analyst-operations-san-bruno-ca"
web99 <- read_html(link99)
job99 <- web99 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview99 <- web99 %>%
        html_node(".job-description__overview") %>%
        html_text()

link100 <- "https://careers.walmart.com/us/jobs/836193BR-sr-mgr-strategic-partnerships-iot-san-bruno-ca"
web100 <- read_html(link100)
job100 <- web100 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview100 <- web100 %>%
        html_node(".job-description__overview") %>%
        html_text()

link101 <- "https://careers.walmart.com/us/jobs/874052BR-product-manager-retail-core-engine-sunnyvale-ca"
web101 <- read_html(link101)
job101 <- web101 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview101 <- web101 %>%
        html_node(".job-description__overview") %>%
        html_text()

link102 <- "https://careers.walmart.com/us/jobs/871235BR-sr-manager-ii-customer-insights-analytics-san-bruno-ca"
web102 <- read_html(link102)
job102 <- web102 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview102 <- web102 %>%
        html_node(".job-description__overview") %>%
        html_text()

link103 <- "https://careers.walmart.com/us/jobs/946201BR-process-mgr-ii-gss-bentonville-ar"
web103 <- read_html(link103)
job103 <- web103 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview103 <- web103 %>%
        html_node(".job-description__overview") %>%
        html_text()

link104 <- "https://careers.walmart.com/us/jobs/876454BR-sr-manager-corporate-accounting-controls-bentonville-ar"
web104 <- read_html(link104)
job104 <- web104 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview104 <- web104 %>%
        html_node(".job-description__overview") %>%
        html_text()

link105 <- "https://careers.walmart.com/us/jobs/914528BR-senior-manager-ii-new-customer-propositions-ecommerce-operations-san-bruno-ca"
web105 <- read_html(link105)
job105 <- web105 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview105 <- web105 %>%
        html_node(".job-description__overview") %>%
        html_text()

link106 <- "https://careers.walmart.com/us/jobs/925409BR-senior-product-manager-cart-checkout-team-san-bruno-ca"
web106 <- read_html(link106)
job106 <- web106 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview106 <- web106 %>%
        html_node(".job-description__overview") %>%
        html_text()

link107 <- "https://careers.walmart.com/us/jobs/954395BR-category-manager-footwear-san-bruno-ca"
web107 <- read_html(link107)
job107 <- web107 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview107 <- web107 %>%
        html_node(".job-description__overview") %>%
        html_text()

link108 <- "https://careers.walmart.com/us/jobs/925850BR-marketing-manager-online-marketing-san-bruno-ca"
web108 <- read_html(link108)
job108 <- web108 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview108 <- web108 %>%
        html_node(".job-description__overview") %>%
        html_text()

link109 <- "https://careers.walmart.com/us/jobs/917255BR-senior-interaction-designer-mexico-sunnyvale-ca"
web109 <- read_html(link109)
job109 <- web109 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview109 <- web109 %>%
        html_node(".job-description__overview") %>%
        html_text()

link110 <- "https://careers.walmart.com/us/jobs/950084BR-category-manager-large-appliances-san-bruno-ca"
web110 <- read_html(link110)
job110 <- web110 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview110 <- web110 %>%
        html_node(".job-description__overview") %>%
        html_text()

link111 <- "https://careers.walmart.com/us/jobs/877842BR-sr-tririga-developer-austin-tx"
web111 <- read_html(link111)
job111 <- web111 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview111 <- web111 %>%
        html_node(".job-description__overview") %>%
        html_text()

link112 <- "https://careers.walmart.com/us/jobs/912081BR-process-lead-ii-general-accounting-bentonville-ar"
web112 <- read_html(link112)
job112 <- web112 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview112 <- web112 %>%
        html_node(".job-description__overview") %>%
        html_text()

link113 <- "https://careers.walmart.com/us/jobs/842855BR-process-lead-ii-cash-banking-reconciliation-bentonville-ar"
web113 <- read_html(link113)
job113 <- web113 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview113 <- web113 %>%
        html_node(".job-description__overview") %>%
        html_text()

link114 <- "https://careers.walmart.com/us/jobs/949357BR-head-of-design-mexico-sunnyvale-ca"
web114 <- read_html(link114)
job114 <- web114 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview114 <- web114 %>%
        html_node(".job-description__overview") %>%
        html_text()

link115 <- "https://careers.walmart.com/us/jobs/917845BR-product-manager-walmart-mexico-sunnyvale-ca"
web115 <- read_html(link115)
job115 <- web115 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview115 <- web115 %>%
        html_node(".job-description__overview") %>%
        html_text()

link116 <- "https://careers.walmart.com/us/jobs/949723BR-driver-coordinator-midway-tn"
web116 <- read_html(link116)
job116 <- web116 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview116 <- web116 %>%
        html_node(".job-description__overview") %>%
        html_text()

link117 <- "https://careers.walmart.com/us/jobs/945702BR-business-analyst-walmart-merchandising-bentonville-ar"
web117 <- read_html(link117)
job117 <- web117 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview117 <- web117 %>%
        html_node(".job-description__overview") %>%
        html_text()

link118 <- "https://careers.walmart.com/us/jobs/955907BR-senior-statistical-analyst-global-people-analytics-bentonville-ar"
web118 <- read_html(link118)
job118 <- web118 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview118 <- web118 %>%
        html_node(".job-description__overview") %>%
        html_text()

link119 <- "https://careers.walmart.com/us/jobs/923968BR-analyst-ii-analytics-compliance-ethics-bentonville-ar"
web119 <- read_html(link119)
job119 <- web119 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview119 <- web119 %>%
        html_node(".job-description__overview") %>%
        html_text()

link120 <- "https://careers.walmart.com/us/jobs/948979BR-senior-statistical-analyst-bentonville-ar"
web120 <- read_html(link120)
job120 <- web120 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview120 <- web120 %>%
        html_node(".job-description__overview") %>%
        html_text()

link121 <- "https://careers.walmart.com/us/jobs/871414BR-sr-manager-bi-and-analytics-hr-global-people-analytics-bentonville-ar"
web121 <- read_html(link121)
job121 <- web121 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview121 <- web121 %>%
        html_node(".job-description__overview") %>%
        html_text()

link122 <- "https://careers.walmart.com/us/jobs/855524BR-merchandise-analytics-manager-walmart-merchandising-bentonville-ar"
web122 <- read_html(link122)
job122 <- web122 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview122 <- web122 %>%
        html_node(".job-description__overview") %>%
        html_text()

link123 <- "https://careers.walmart.com/us/jobs/949404BR-r-quality-assurance-associate-buckeye-az"
web123 <- read_html(link123)
job123 <- web123 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview123 <- web123 %>%
        html_node(".job-description__overview") %>%
        html_text()


link124 <- "https://careers.walmart.com/us/jobs/908652BR-staff-software-engineer-open-api-iot-sunnyvale-ca"
web124 <- read_html(link124)
job124 <- web124 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview124 <- web124 %>%
        html_node(".job-description__overview") %>%
        html_text()


link125 <- "https://careers.walmart.com/us/jobs/926125BR-facilitator-continuous-improvement-finance-operations-walmartcom-bentonville-ar"
web125 <- read_html(link125)
job125 <- web125 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview125 <- web125 %>%
        html_node(".job-description__overview") %>%
        html_text()


link126 <- "https://careers.walmart.com/us/jobs/873503BR-programmer-analyst-analytics-isd-bentonville-ar"
web126 <- read_html(link126)
job126 <- web126 %>% 
        html_node(".qualification__value ") %>% 
        html_text()
joboverview126 <- web126 %>%
        html_node(".job-description__overview") %>%
        html_text()

setwd("C:/Users/jletcher/Documents/Bellarmine/Assignments/Text Mining Term Project")

clean_ids <- read.csv("Walmart Ids.csv")

job_total <- rbind(job1, job2, job3, job4, job5, job6, job7, job8, job9, job10, job11, job12, job13, job14, job15, job16, job17,
                   job18, job19, job20, job21, job22, job23, job24, job25, job26, job27, job28, job29, job30, job31, job32,
                   job33, job34, job35, job36, job37, job38, job39, job40, job41, job42, job43, job44, job45, job46, job47, job48,
                   job49, job50, job51, job52, job53, job54, job55, job56, job57, job58, job59, job60, job61, job62, job63,
                   job64, job65, job66, job67, job68, job69, job70, job71, job72, job73, job74, job75, job76, job77, job78,
                   job79, job80, job81, job82, job83, job84, job85, job86, job87, job88, job89, job90, job91, job92, job93, job94,
                   job95, job96, job97, job98, job99, job100, job101, job102, job103, job104, job105, job106, job107, job108,
                   job109, job110, job111, job112, job113, job114, job115, job116, job117, job118, job119, job120, job121, job122,
                   job123, job124, job125, job126)

joboverview_total <- rbind(joboverview1, joboverview2, joboverview3, joboverview4, joboverview5, joboverview6, joboverview7, joboverview8, 
                                   joboverview9, joboverview10, joboverview11, joboverview12, joboverview13, joboverview14, joboverview15, joboverview16, 
                                   joboverview17,joboverview18, joboverview19, joboverview20, joboverview21, joboverview22, joboverview23, joboverview24, 
                                   joboverview25, joboverview26, joboverview27, joboverview28, joboverview29, joboverview30, joboverview31, joboverview32,
                                   joboverview33, joboverview34, joboverview35, joboverview36, joboverview37, joboverview38, joboverview39, joboverview40, 
                                   joboverview41, joboverview42, joboverview43, joboverview44, joboverview45, joboverview46, joboverview47, joboverview48,
                                   joboverview49, joboverview50, joboverview51, joboverview52, joboverview53, joboverview54, joboverview55, joboverview56, 
                                   joboverview57, joboverview58, joboverview59, joboverview60, joboverview61, joboverview62, joboverview63, joboverview64, 
                                   joboverview65, joboverview66, joboverview67, joboverview68, joboverview69, joboverview70, joboverview71, joboverview72, 
                                   joboverview73, joboverview74, joboverview75, joboverview76, joboverview77, joboverview78, joboverview79, joboverview80, 
                                   joboverview81, joboverview82, joboverview83, joboverview84, joboverview85, joboverview86, joboverview87, joboverview88, 
                                   joboverview89, joboverview90, joboverview91, joboverview92, joboverview93, joboverview94, joboverview95, joboverview96, 
                                   joboverview97, joboverview98, joboverview99, joboverview100, joboverview101, joboverview102, joboverview103, joboverview104, 
                                   joboverview105, joboverview106, joboverview107, joboverview108, joboverview109, joboverview110, joboverview111, joboverview112, 
                                   joboverview113, joboverview114, joboverview115, joboverview116, joboverview117, joboverview118, joboverview119, joboverview120, 
                                   joboverview121, joboverview122, joboverview123, joboverview124, joboverview125, joboverview126)


jobs <- cbind(clean_ids, job_total, joboverviewoverview_total)

walmart <- write.csv(jobs, "Jobs.csv")


#Job Query

#/us/jobs/855524BR-merchandise-analytics-manager-walmart-merchandising-bentonville-ar
#/us/jobs/949404BR-r-quality-assurance-associate-buckeye-az
#/us/jobs/908652BR-staff-software-engineer-open-api-iot-sunnyvale-ca
#/us/jobs/926125BR-facilitator-continuous-improvement-finance-operations-walmartcom-bentonville-ar
#/us/jobs/873503BR-programmer-analyst-analytics-isd-bentonville-ar
#/us/jobs/886329BR-senior-programmer-analyst-isd-bentonville-ar
#/us/jobs/861709BR-programmer-analyst-isd-bentonville-ar
#/us/jobs/868985BR-developer-i-isd-east-reston-va
#/us/jobs/870385BR-developer-ii-isd-east-reston-va
#/us/jobs/863207BR-quality-engineering-expert-bentonville-ar
#/us/jobs/877723BR-technical-expert-isd-bentonville-ar
#/us/jobs/878951BR-programmer-isd-bentonville-ar
#/us/jobs/822826BR-staff-devops-engineer-sunnyvale-ca
#/us/jobs/847283BR-developer-ii-isd-east-reston-va
#/us/jobs/851220BR-programmer-analyst-isd-net-bentonville-ar
#/us/jobs/859852BR-senior-software-engineer-front-end-sunnyvale-ca
#/us/jobs/852605BR-senior-programmer-analyst-isd-full-stack-bentonville-ar
#/us/jobs/956279BR-senior-platform-engineer-predictive-analytics-platform-sunnyvale-ca
#/us/jobs/932109BR-data-analyst-sunnyvale-ca
#/us/jobs/949505BR-senior-data-analyst-san-bruno-ca
#/us/jobs/944402BR-senior-statistical-analyst-data-analytics-sunnyvale-ca
#/us/jobs/877573BR-senior-programmer-analyst-isd-big-data-bentonville-ar
#/us/jobs/946527BR-manager-data-analytics-bentonville-ar
#/us/jobs/867762BR-senior-programmer-analyst-isd-big-data-hadoop-bentonville-ar
#/us/jobs/868950BR-director-retail-data-science-bentonville-ar
#/us/jobs/924791BR-data-scientist-san-bruno-ca
#/us/jobs/886678BR-systems-analyst-analytics-isd-hadoop-big-data-bentonville-ar
#/us/jobs/875213BR-principal-data-scientist-sunnyvale-ca
#/us/jobs/872692BR-data-assurance-analyst-iii-bentonville-ar
#/us/jobs/879217BR-staff-data-scientist-san-bruno-ca
#/us/jobs/840811BR-distinguished-data-scientist-san-bruno-ca
#/us/jobs/890961BR-senior-data-scientist-bentonville-ar
#/us/jobs/872453BR-machine-learning-data-scientist-sunnyvale-ca
#/us/jobs/905893BR-data-scientist-search-team-sunnyvale-ca
#/us/jobs/851630BR-data-scientist-isd-bentonville-ar
#/us/jobs/872770BR-data-assurance-researcher-cybersecurity-wmtech-bentonville-ar
#/us/jobs/870437BR-data-assurance-analyst-iii-cybersecurity-wmtech-bentonville-ar
#/us/jobs/867746BR-associate-data-scientist-isd-bentonville-ar
#/us/jobs/835513BR-associate-data-scientist-machine-learning-austin-tx
#/us/jobs/931213BR-principal-software-engineer-big-data-systems-sunnyvale-ca
#/us/jobs/912902BR-senior-big-data-tools-engineer-sunnyvale-ca
#/us/jobs/933905BR-sr-director-retail-data-science-san-bruno-ca
#/us/jobs/875199BR-staff-data-scientist-anti-fraud-sunnyvale-ca
#/us/jobs/908651BR-senior-software-engineer-search-big-data-sunnyvale-ca
#/us/jobs/827039BR-sr-statistic-analyst-data-analytics-isd-bentonville-ar
#/us/jobs/868987BR-statistical-analyst-bentonville-ar
#/us/jobs/872239BR-sr-manager-analytics-and-reporting-global-audits-bentonville-ar
#/us/jobs/930990BR-2018-summer-internship-central-operations-data-scientist-bentonville-ar
#/us/jobs/936597BR-senior-manager-customer-analytics-global-insights-san-bruno-ca
#/us/jobs/891658BR-advanced-systems-engineer-data-center-isd-bentonville-ar
#/us/jobs/905876BR-software-engineer-iii-big-data-machine-learning-sunnyvale-ca
#/us/jobs/921007BR-sr-data-analyst-vudu-sunnyvale-ca
#/us/jobs/918188BR-senior-taxonomist-structured-data-ho-wec-wmtech-bentonville-ar
#/us/jobs/679949BR-planner-travel-sourcing-and-analytics-walmart-global-travel-bentonville-ar
#/us/jobs/900679BR-2018-full-time-gp-programmer-analyst-data-platforms-bentonville-ar
#/us/jobs/905434BR-2018-full-time-gbs-programmer-analyst-data-strategy-coe-bentonville-ar
#/us/jobs/939609BR-director-engineering-sunnyvale-ca
#/us/jobs/802632BR-operations-analyst-cross-border-san-bruno-ca
#/us/jobs/879027BR-technical-product-manager-sunnyvale-ca
#/us/jobs/938097BR-staff-software-engineer-sunnyvale-ca
#/us/jobs/888388BR-senior-manager-ii-digital-experience-roadmap-san-bruno-ca
#/us/jobs/926439BR-temporary-support-specialist-billing-recoveries-bentonville-ar
#/us/jobs/888294BR-sr-software-engineer-cybersec-wmtech-bentonville-ar
#/us/jobs/873254BR-manager-analytics-and-planning-san-bruno-ca
#/us/jobs/950541BR-temp-services-e-bentonville-ar
#/us/jobs/950544BR-temporary-specialist-iii-bentonville-ar
#/us/jobs/900723BR-2018-full-time-sams-technology-sr-statistical-analyst-bentonville-ar
#/us/jobs/900224BR-2018-full-time-gp-sr-statistical-analyst-retail-analytics-bentonville-ar
#/us/jobs/807093BR-supply-chain-associate-san-bruno-ca
#/us/jobs/825219BR-senior-manager-customer-analytics-vudu-sunnyvale-ca
#/us/jobs/936492BR-temporary-specialist-iv-bentonville-ar
#/us/jobs/943232BR-product-manager-grocery-analytics-san-bruno-ca
#/us/jobs/837180BR-manager-business-analytics-insights-san-bruno-ca
#/us/jobs/922104BR-associate-manager-new-customer-propositions-ecomm-ops-san-bruno-ca
#/us/jobs/947800BR-principal-software-engineer-database-devops-carlsbad-ca
#/us/jobs/950082BR-director-product-management-product-partnerships-growth-san-bruno-ca
#/us/jobs/834624BR-senior-manager-site-analytics-san-bruno-ca
#/us/jobs/885370BR-analyst-ii-analytics-forensics-audit-finance-bentonville-ar
#/us/jobs/858618BR-principal-platform-engineer-predictive-analytics-platform-sunnyvale-ca
#/us/jobs/827398BR-staff-platform-engineer-predictive-analytics-platform-sunnyvale-ca
#/us/jobs/943063BR-temporary-cash-application-specialist-bentonville-ar
#/us/jobs/930891BR-temporary-specialist-iv-global-business-services-bentonville-ar
#/us/jobs/884132BR-senior-manager-category-analytics-home-san-bruno-ca
#/us/jobs/884135BR-senior-manager-category-analytics-entertainment-san-bruno-ca
#/us/jobs/934776BR-compensation-analyst-hr-bentonville-ar
#/us/jobs/904202BR-associate-product-manager-san-bruno-ca
#/us/jobs/874264BR-senior-manager-partnership-analytics-reporting-san-bruno-ca
#/us/jobs/894750BR-senior-software-engineer-java-node-js-sunnyvale-ca
#/us/jobs/880158BR-full-stack-staff-software-engineer-behavioral-telemetry-sunnyvale-ca
#/us/jobs/921595BR-project-manager-workforce-management-temporary-bentonville-ar
#/us/jobs/945981BR-associate-product-manager-pickup-analytics-san-bruno-ca
#/us/jobs/809763BR-supply-chain-associate-san-bruno-ca
#/us/jobs/941423BR-temporary-cad-specialist-bentonville-ar
#/us/jobs/931000BR-2018-summer-internship-human-resources-selection-assessment-bentonville-ar
#/us/jobs/935067BR-senior-ios-engineer-sunnyvale-ca
#/us/jobs/920751BR-senior-manager-cost-analytics-san-bruno-ca
#/us/jobs/879666BR-senior-analyst-finance-business-systems-san-bruno-ca
#/us/jobs/852829BR-senior-manager-strategy-san-bruno-ca
#/us/jobs/935138BR-associate-analyst-operations-san-bruno-ca
#/us/jobs/836193BR-sr-mgr-strategic-partnerships-iot-san-bruno-ca
#/us/jobs/874052BR-product-manager-retail-core-engine-sunnyvale-ca
#/us/jobs/871235BR-sr-manager-ii-customer-insights-analytics-san-bruno-ca
#/us/jobs/946201BR-process-mgr-ii-gss-bentonville-ar
#/us/jobs/876454BR-sr-manager-corporate-accounting-controls-bentonville-ar
#/us/jobs/914528BR-senior-manager-ii-new-customer-propositions-ecommerce-operations-san-bruno-ca
#/us/jobs/925409BR-senior-product-manager-cart-checkout-team-san-bruno-ca
#/us/jobs/954395BR-category-manager-footwear-san-bruno-ca
#/us/jobs/925850BR-marketing-manager-online-marketing-san-bruno-ca
#/us/jobs/917255BR-senior-interaction-designer-mexico-sunnyvale-ca
#/us/jobs/950084BR-category-manager-large-appliances-san-bruno-ca
#/us/jobs/877842BR-sr-tririga-developer-austin-tx
#/us/jobs/912081BR-process-lead-ii-general-accounting-bentonville-ar
#/us/jobs/842855BR-process-lead-ii-cash-banking-reconciliation-bentonville-ar
#/us/jobs/949357BR-head-of-design-mexico-sunnyvale-ca
#/us/jobs/917845BR-product-manager-walmart-mexico-sunnyvale-ca
#/us/jobs/949723BR-driver-coordinator-midway-tn
#/us/jobs/945702BR-business-analyst-walmart-merchandising-bentonville-ar
#/us/jobs/955907BR-senior-statistical-analyst-global-people-analytics-bentonville-ar
#/us/jobs/923968BR-analyst-ii-analytics-compliance-ethics-bentonville-ar
#/us/jobs/948979BR-senior-statistical-analyst-bentonville-ar
#/us/jobs/871414BR-sr-manager-bi-and-analytics-hr-global-people-analytics-bentonville-ar

# Attempt at advance code

src = xpathApply(web, "//a[@href]", xmlGetAttr, "href")

//*[@id="search-results"]/li[1]/div[1]/div[1]/h4/a

