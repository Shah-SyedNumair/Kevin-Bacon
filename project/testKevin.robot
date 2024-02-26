*** Settings ***
Library           Collections
Library           RequestsLibrary
Test Timeout      30 seconds

*** Test Cases ***
addActorPass
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    name=Dwayne Johnson    actorId=nm0000001
    ${resp}=    Put Request    localhost    /api/v1/addActor    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

addActorFail
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    name=Ronak    actorId=nm0000002
    ${resp}=    Put Request    localhost    /api/v1/addActor    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

addActorFail2
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    name=Dwayne Johnson   actorId=
    ${resp}=    Put Request    localhost    /api/v1/addActor    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

addMoviePass
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    name=Rampage   movieId=nm0000003
    ${resp}=    Put Request    localhost    /api/v1/addMovie   data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

addMovieFail
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    name=cocolo   movieId=nm0000004
    ${resp}=    Put Request    localhost    /api/v1/addMovie    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

addMovieFail2
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    name=Rampage   movieId=
    ${resp}=    Put Request    localhost    /api/v1/addMovie    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

addStudioPass
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    name=Warner Bros   studioId=nm0000005
    ${resp}=    Put Request    localhost    /api/v1/addStudio    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

addStudioFail
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    name=Numair Studios   studioId=nm0000006
    ${resp}=    Put Request    localhost    /api/v1/addStudio    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

addStudioFail2
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    name=Universal Pictures  studioId=
    ${resp}=    Put Request    localhost    /api/v1/addStudio    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

addRatingPass
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    name=PG-13 ratingId=nm0000007
    ${resp}=    Put Request    localhost    /api/v1/addRating    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

addRatingFail
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    name=GGS   ratingId=nm0000008
    ${resp}=    Put Request    localhost    /api/v1/addRating    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

addRatingFail2
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    name=R   ratingId=
    ${resp}=    Put Request    localhost    /api/v1/addRating    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

addLanguagePass
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    name=English  languageId=nm0000009
    ${resp}=    Put Request    localhost    /api/v1/addLanguage    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

addLanguageFail
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    name=Ohio  languageId=nm0000010
    ${resp}=    Put Request    localhost    /api/v1/addLanguage    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

addLanguageFail2
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    name=English  languageId=
    ${resp}=    Put Request    localhost    /api/v1/addLanguage    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

addRelationshipPass
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    actorId=nm0000001  movieId=nm0000003
    ${resp}=    Put Request    localhost    /api/v1/addRelationship    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

addRelationshipFail
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    actorId=nm0000001  movieId=nm0060003
    ${resp}=    Put Request    localhost    /api/v1/addRelationship    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    404

addRelationshipFail2
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    actorId=nm0000001  movieId=nm0000003
    ${resp}=    Put Request    localhost    /api/v1/addRelationship    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

addRelationshipFail3
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    actorId= movieId=
    ${resp}=    Put Request    localhost    /api/v1/addRelationship    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

addStudioRelationPass
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    studioId=nm0000005  movieId=nm0000003
    ${resp}=    Put Request    localhost    /api/v1/addStudioRelation    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

addStudioRelationFail
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    studioId=nm0000005  movieId=nm0070003
    ${resp}=    Put Request    localhost    /api/v1/addStudioRelation    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    404

addStudioRelationFail2
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    studioId=nm0000005  movieId=nm0000003
    ${resp}=    Put Request    localhost    /api/v1/addStudioRelation    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

addStudioRelationFail3
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    studioId=  movieId=
    ${resp}=    Put Request    localhost    /api/v1/addStudioRelation    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

addRatingRelationPass
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    ratingId=nm0000007  movieId=nm0000003
    ${resp}=    Put Request    localhost    /api/v1/addRatingRelation    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

addRatingRelationFail
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    ratingId=nm0000007  movieId=nm0090003
    ${resp}=    Put Request    localhost    /api/v1/addRatingRelation    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    404

addRatingRelationFail2
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    ratingId=nm0000007  movieId=nm0000003
    ${resp}=    Put Request    localhost    /api/v1/addRatingRelation    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

addRatingRelationFail3
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    ratingId=  movieId=
    ${resp}=    Put Request    localhost    /api/v1/addRatingRelation    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

addLanguageRelationPass
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   languageId=nm0000009  movieId=nm0000003
    ${resp}=    Put Request    localhost    /api/v1/addLanguageRelation    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

addLanguageRelationFail
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    languageId=nm0000009  movieId=nm0020003
    ${resp}=    Put Request    localhost    /api/v1/addLanguageRelation    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    404

addLanguageRelationFail2
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    languageId=nm0000009  movieId=nm0000003
    ${resp}=    Put Request    localhost    /api/v1/addLanguageRelation    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

addLanguageRelationFail3
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary    languageId=  movieId=
    ${resp}=    Put Request    localhost    /api/v1/addLanguageRelation    data=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

getActorPass
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   actorId=nm0000001  movieId=nm0000003
    ${L1}= ['Rampage']
    ${value}= Get From Dictionary ${resp.json()} movies
    Should Be Equal As String ${value} ${L1}
    ${resp}=    Put Request    localhost    /api/v1/getActor    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

getActorEmptyPass
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   actorId=nm0000001  movieId=nm0000003
    ${L1}= []
    ${value}= Get From Dictionary ${resp.json()} movies
    Should Be Equal As String ${value} ${L1}
    ${resp}=    Put Request    localhost    /api/v1/getActor    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

getActorFail2
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   actorId=nm0900001  movieId=nm0000003
    ${resp}=    Put Request    localhost    /api/v1/getActor    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    404

getActorFail
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   actorId=  movieId=nm0000003
    ${resp}=    Put Request    localhost    /api/v1/getActor    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

getMoviePass
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   actorId=nm0000001  movieId=nm0000003
    ${L2}= ['Dwayne Johnson']
    ${value}= Get From Dictionary ${resp.json()} actors
    Should Be Equal As String ${value} ${L2}
    ${resp}=    Put Request    localhost    /api/v1/getMovie    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

getMovieEmptyPass
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   actorId=nm0000001  movieId=nm0000003
    ${L2}= []
    ${value}= Get From Dictionary ${resp.json()} actors
    Should Be Equal As String ${value} ${L2}
    ${resp}=    Put Request    localhost    /api/v1/getMovie    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

getMovieFail2
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   actorId=nm0000001  movieId=nm0070003
    ${resp}=    Put Request    localhost    /api/v1/getMovie    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    404

getMovieFail
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   actorId=nm0000001  movieId=
    ${resp}=    Put Request    localhost    /api/v1/getMovie    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

getStudioPass
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   studioId=nm0000005  movieId=nm0000003
    ${L3}= ['Rampage']
    ${value}= Get From Dictionary ${resp.json()} studios
    Should Be Equal As String ${value} ${L3}
    ${resp}=    Put Request    localhost    /api/v1/getStudio    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

getStudioEmptyPass
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   studioId=nm0000005  movieId=nm0000003
    ${L3}= []
    ${value}= Get From Dictionary ${resp.json()} studios
    Should Be Equal As String ${value} ${L3}
    ${resp}=    Put Request    localhost    /api/v1/getStudio    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

getStudioFail
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   studioId=  movieId=nm0000003
    ${resp}=    Put Request    localhost    /api/v1/getStudio    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

getStudioFail2
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   studioId=nm0003005  movieId=nm0000003
    ${resp}=    Put Request    localhost    /api/v1/getStudio    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    404

getRatingPass
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   ratingId=nm0000007  movieId=nm0000003
    ${L4}= ['Rampage']
    ${value}= Get From Dictionary ${resp.json()} ratings
    Should Be Equal As String ${value} ${L4}
    ${resp}=    Put Request    localhost    /api/v1/getRating    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

getRatingEmptyPass
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   ratingId=nm0000007  movieId=nm0000003
    ${L4}= []
    ${value}= Get From Dictionary ${resp.json()} ratings
    Should Be Equal As String ${value} ${L4}
    ${resp}=    Put Request    localhost    /api/v1/getRating    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

getRatingFail
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   ratingId=  movieId=nm0000003
    ${resp}=    Put Request    localhost    /api/v1/getRating    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

getRatingFail2
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   ratingId=nm8000007  movieId=nm0000003
    ${resp}=    Put Request    localhost    /api/v1/getRating    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    404

getLanguagePass
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   languageId=nm0000009  movieId=nm0000003
    ${L5}= ['Rampage']
    ${value}= Get From Dictionary ${resp.json()} languages
    Should Be Equal As String ${value} ${L5}
    ${resp}=    Put Request    localhost    /api/v1/getLanguage    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

getLanguageEmptyPass
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   languageId=nm0000009  movieId=nm0000003
    ${L5}= []
    ${value}= Get From Dictionary ${resp.json()} languages
    Should Be Equal As String ${value} ${L5}
    ${resp}=    Put Request    localhost    /api/v1/getLanguage    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

getLanguageFail
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   languageId=  movieId=nm0000003
    ${resp}=    Put Request    localhost    /api/v1/getLanguage    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

getLanguageFail2
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   languageId=nm0020009  movieId=nm0000003
    ${resp}=    Put Request    localhost    /api/v1/getLanguage    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    404

hasRelationshipPass
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   actorId=nm0000001  movieId=nm0000003
    ${value}= Get From Dictionary ${resp.json()} ${false}
    ${resp}=    Put Request    localhost    /api/v1/hasRelationship    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

hasRelationshipPass2
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   actorId=nm0000001  movieId=nm0000003
    ${value}= Get From Dictionary ${resp.json()} ${true}
    ${resp}=    Put Request    localhost    /api/v1/hasRelationship    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

hasRelationshipFail
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   actorId= movieId=nm0000003
    ${resp}=    Put Request    localhost    /api/v1/hasRelationship    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

hasRelationshipFail2
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   actorId=nm0300001  movieId=nm0000003
    ${resp}=    Put Request    localhost    /api/v1/hasRelationship    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    404

hasStudioRelationshipPass
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   studioId=nm0000005  movieId=nm0000003
    ${value}= Get From Dictionary ${resp.json()} ${false}
    ${resp}=    Put Request    localhost    /api/v1/hasStudioRelationship    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

hasStudioRelationshipPass2
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   studioId=nm0000005  movieId=nm0000003
    ${value}= Get From Dictionary ${resp.json()} ${true}
    ${resp}=    Put Request    localhost    /api/v1/hasStudioRelationship    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

hasStudioRelationshipFail
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   studioId= movieId=nm0000003
    ${resp}=    Put Request    localhost    /api/v1/hasStudioRelationship    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

hasStudioRelationshipFail2
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   studioId=nm7000005  movieId=nm0000003
    ${resp}=    Put Request    localhost    /api/v1/hasStudioRelationship    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    404

isRatedPass
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   ratingId=nm0000007  movieId=nm0000003
    ${value}= Get From Dictionary ${resp.json()} ${false}
    ${resp}=    Put Request    localhost    /api/v1/isRated    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

isRatedPass2
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   ratingId=nm0000007  movieId=nm0000003
    ${value}= Get From Dictionary ${resp.json()} ${true}
    ${resp}=    Put Request    localhost    /api/v1/isRated    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

isRatedFail
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   ratingId=  movieId=nm0000003
    ${resp}=    Put Request    localhost    /api/v1/isRated    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

isRatedFail2
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   ratingId=nm0200007  movieId=nm0000003
    ${resp}=    Put Request    localhost    /api/v1/isRated    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    404

speaksInPass
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   languageId=nm0000009  movieId=nm0000003
    ${value}= Get From Dictionary ${resp.json()} ${false}
    ${resp}=    Put Request    localhost    /api/v1/speaksIn    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

speaksInPass2
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   languageId=nm0000009  movieId=nm0000003
    ${value}= Get From Dictionary ${resp.json()} ${true}
    ${resp}=    Put Request    localhost    /api/v1/speaksIn    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

speaksInFail
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   languageId=  movieId=nm0000003
    ${resp}=    Put Request    localhost    /api/v1/speaksIn    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

speaksInFail2
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary   languageId=nm0080009  movieId=nm0000003
    ${resp}=    Put Request    localhost    /api/v1/speaksIn    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    404

computeBaconNumberPass
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary     actorId=nm0000001
    ${L6}= ['2']
    ${value}= Get From Dictionary ${resp.json()} number
    Should Be Equal As String ${value} ${L6}
    ${resp}=    Put Request    localhost    /api/v1/computeBaconNumber    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200

computeBaconNumberFail
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary     actorId=
    ${resp}=    Put Request    localhost    /api/v1/computeBaconNumber    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

computeBaconNumberFail2
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary     actorId=nm0203001
    ${resp}=    Put Request    localhost    /api/v1/computeBaconNumber    JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    404


computeBaconPathFail
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary     actorId=
    ${resp}=    Put Request    localhost    /api/v1/computeBaconPath   JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    400

computeBaconPathFail2
    Create Session    localhost    http://localhost:8080
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${params}=    Create Dictionary     actorId=nm0203401
    ${resp}=    Put Request    localhost    /api/v1/computeBaconPath   JSON=${params}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    404