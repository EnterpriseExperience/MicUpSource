Players = game:GetService("Players")
Workspace = game:GetService("Workspace")
UserInputService = game:GetService("UserInputService")
RunService = game:GetService("RunService")
ReplicatedStorage = game:GetService("ReplicatedStorage")
TweenService = game:GetService("TweenService")
LocalPlayer = Players.LocalPlayer
HttpService = game:GetService("HttpService")

local ghostEnabled = false
local originalCharacter
local ghostClone
local originalCFrame
local originalAnimateScript
local updateConnection

local ghostOriginalHipHeight

local cloneSize = 1
local cloneWidth = 1

local ghostOriginalSizes = {}
local ghostOriginalMotorCFrames = {}

local body_parts = {
    "Head", "UpperTorso", "LowerTorso",
    "LeftUpperArm", "LeftLowerArm", "LeftHand",
    "RightUpperArm", "RightLowerArm", "RightHand",
    "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
    "RightUpperLeg", "RightLowerLeg", "RightFoot"
}

local BuiltInAnimationsR15 = {
    ["Swastika"] = 93170225110433,
    ["big swastika"] = 94631359696320,
    ["rat dance"] = 78114662261380,
    ["Griddy"] = 8916572099,
    ["Sturdy"] = 137959340008695,
    ["Float"] = 12256726178,
    ["Last Forever"] = 8874201750,
    ["Ride It"] = 6863561770,
    ["Fan Dance"] = 12928948342,
    ["IDOL"] = 104706018817755,
    ["NTTL"] = 93580979672065,
    ["Fucking Running 🔥"] = 12712457641,
    ["Weird ass breakdancing"] = 7070158948,
    ["Bumblebee"] = 13834565433,
    ["Cash Dance"] = 7041113269,
    ["Electro Shuffle"] = 9116910876,
    ["APT"] = 84631084374226,
    ["Sigma Boy"] = 92757660068329,
    ["Mask Off"] = 77901877634801,
    ["Alibi"] = 122664034133915,
    ["Be Gone"] = 18552943923,
    ["Bim Bam Boom"] = 18552948159,
    ["Boogie Down"] = 18552972055,
    ["Dimensional"] = 140255515874482,
    ["Gangnam Style"] = 18553011864,
    ["Jubi Slide / Slick Back"] = 107444119659023,
    ["Macarena"] = 18553106741,
    ["Slim Shady"] = 18553150120,
    ["Backflip"] = 18550514533,
    ["McDonalds at 3am in the morning 🤯"] = 7248304620,
    ["roll and rock"] = 11056185537,
    ["laid back shuffle"] = 8791067671,
    ["deposits"] = 7585369035,
    ["smooth winner"] = 7573570614,
    ["sway around"] = 11641870089,
    ["all night"] = 12201164828,
    ["hana"] = 11605072407,
    ["phon hon"] = 7350048609,
    ["poppy love (Automotivo Xm, Taka Taka Taka Tá)"] = 16114220538,
    ["moster mash (judas)"] = 11537307923,
    ["shift (Government Hooker)"] = 11537224630,
    ["sturdyV2 (Love Me, Hate Me k3lah)"] = 11664843153,
    ["lia kim (In For It (XODDIAC Remix))"] = 8111230734,
    ["get started (Лето)"] = 10734797398,
    ["phonk music fr"] = 7232575007,
    ["Cold Out"] = 90779822053049,
    ["Did it first"] = 104924566284253,
    ["Keep Up"] = 80586234339889,
    ["Embrace It"] = 72117290471362,
    ["Wannabe space girls smooth"] = 14837825883,
    ["Pump it"] = 13842488942,
    ["Toca Toca"] = 14455340647,
    ["Toca Toca V2"] = 12916840571,
    ["Dancin"] = 9716509653,
    ["Paint The Town Red"] = 14901879394,
    ["Say So"] = 14034144806,
    ["Shake it off"] = 18952701833,
    ["Snoop's walk"] = 132477655284495,
    ["Social Climber"] = 16827106432,
    ["Starship ( nicki minaj )"] = 17598989892,
    ["Starlift"] = 18532446643,
    ["Stay"] = 12792347172,
    ["Stuck ( Cardi B )"] = 17450628542,
    ["Thank you next!"] = 13772961479,
    ["That's what i like ( Bruno Mars )"] = 13025071715,
    ["Toothless dance"] = 16214133435,
    ["Umbrella"] = 17566237110,
    ["Work remix ( A2AP Ferg )"] = 17569379378,
    ["YMCA"] = 13460810829,
    ["Coffin"] = 124985182093256,
    ["Call me maybe!"] = 15712992592,
    ["Diva"] = 15635063518,
    ["Gasolina"] = 15052732044,
    ["Talk Dirty"] = 14840663266,
    ["Thriller"] = 15208297905,
    ["Yo Bunny"] = 18655830398,
    ["Woman ( Doja )"] = 14845112417,
    ["Waka Waka"] = 13431512360,
    ["Waka Waka V2"] = 15381915476,
    ["Waiting for love"] = 72053710295476,
    ["Untouchable"] = 17570890409,
    ["Thrift Shop"] = 16753653616,
    ["Timber ( Nightcore )"] = 95495006115572,
    ["Texas Hold ' Em"] = 16625502258,
    ["Swag Beat"] = 115733505136871,
    ["Swalla"] = 18740808703,
    ["Summer"] = 13270529922,
    ["Stay Up"] = 124500473772133,
    ["SpongeBob  ( Jersey club )"] = 10980542151,
    ["Smack Yo"] = 131474670923668,
    ["Smack Yo V2"] = 137990521192304,
    ["Smooth Criminal"] = 13772963837,
    ["Smooth Criminal V2"] = 18402405089,
    ["Simpa"] = 12257423587,
    ["Simpa V2"] = 12453892230,
    ["Skidibi"] = 16756613065,
    ["Skidibi  V2"] = 16757369666,
    ["Shimmer ( fortnite )"] = 16395739858,
    ["Shape of you"] = 12626260779,
    ["Say it Right"] = 14044620822,
    ["Slay Phonk"] = 17353600859,
    ["Rude Boy"] = 13539279783,
    ["Rude Boy V2"] = 16827397883,
    ["Rockstar ( Push Up )"] = 14214317091,
    ["Heel Click Breakdown"] = 18441999758,
    ["teach me how to dougie"] = 7619764422,
    ["out west"] = 18553123644,
    ["Ishowspeed shake dat ass"] = 16455715993,
    ["russian kick (kalinka)"] = 8749319208,
    ["Caramelldansen"] = 110926505486019,
    ["Hot Springs"] = 72570494324774,
    ["Kazotsky Kick"] = 101318053989317,
    ["Slide"] = 119492771813670,
    ["Billie Jean"] = 12764845252,
    ["Blinding Lights"] = 16615772082,
    ["Box Swing"] = 140473666560735,
    ["Breakdance2005"] = 13806018931,
    ["Crank That"] = 9337916456,
    ["Criss Cross"] = 5806077631,
    ["Criss-Cross Toprock"] = 15767639861,
    ["Up Town Funk You Up"] = 10565486365,
    ["Dr. Livesey Walk"] = 71071097427597,
    ["Drip"] = 9836086127,
    ["Entranced"] = 123356412429416,
    ["Fly Dance (Rather Be)"] = 9730153158,
    ["Friday Night"] = 8723336030,
    ["Funky Jig"] = 10909214966,
    ["Gangnam Style"] = 16883073608,
    ["Get Sturdy"] = 12126389709,
    ["Groovy"] = 8208076144,
    ["Holiday"] = 119715551234716,
    ["Insanity"] = 8575452869,
    ["Legal Reasons (PewDiePie T-Series Disstrack)"] = 16513267930,
    ["Newtron Boogie"] = 111093010610650,
    ["Pop And Lock (TikTok - Kesha)"] = 8083855559,
    ["Reflex"] = 8580057295,
    ["Riding It"] = 8038132892,
    ["Rodeo"] = 9292118892,
    ["Sit"] = 4842017973,
    ["The Flop"] = 16513281388,
    ["Thriller"] = 4699820365,
    ["Tootsee Roll"] = 12986187501,
    ["Toprocking"] = 12986187501,
    ["Wednesday"] = 18903731826,
    ["ah yes"] = 3383725246,
    ["Explode"] = 18517277884,
    ["smeeze"] = 18553199244,
    ["to the beat"] = 18553190141,
    ["conga 1"] = 79002139027906,
    ["conga 2"] = 91965031391808,
    ["starlit"] = 18532446643,
    ["surfin' Bird (Peter griffin dance)"] = 130091927678906,
    ["Push ups"] = 16069644453,
    ["punching"] = 16069488698,
    ["Marsh walk"] = 7514926048,
    ["Ashi Ashi"] = 16388690075,
    ["Popular (The Weeknd)"] = 15643535842,
    ["alors on danse"] = 9331423748,
    ["California Girls"] = 125389830710791,
    ["glyphic"] = 14846105925,
    ["go just go"] = 13990340012,
    ["goated"] = 18969257806,
    ["shower"] = 16119477663,
    ["wednesday"] = 18766885785,
    ["walking on a dream"] = 11771777726,
    ["water"] = 15182917055,
    ["wavy"] = 11528196432,
    ["gta dance"] = 18743035691,
    ["giri giri"] = 18655870449,
    ["hakari dance"] = 18846734933,
    ["just dance"] = 11456890837,
    ["shuffle"] = 15783246823,
    ["the dance laroi"] = 75239905741750,
    ["cupid"] = 14458761918,
    ["not my problem"] = 102637131613028,
    ["blurred lines"] = 11682931919,
    ["renai circulation"] = 14881809061,
    ["trance"] = 13461610584,
    ["bibi fogosa"] = 18946055933,
    ["rollie"] = 12386799815,
    ["miss the rage"] = 109658630298836,
    ["fresh"] = 9116897929,
    ["rambunctious"] = 6955675746,
    ["billy bounce"] = 8917592832,
    ["electro swing"] = 7839963379,
    ["jabbaswitchaway"] = 8229514367,
    ["mufasa"] = 8459864580,
    ["tidy"] = 6657942302,
    ["floss"] = 9003921069,
    ["bye bye bye"] = 74459902656965,
    ["jaywalkin"] = 10970927618,
    ["worm"] = 7160307855,
    ["lazer blast"] = 9634449536,
    ["spiderman"] = 8228461600,
    ["flippin sexy"] = 7144733185,
    ["bust a move"] = 15120502730,
    ["surf bird"] = 15576917846,
    ["orange justice"] = 11212163754,
    ["scenario"] = 8924083749,
    ["boppin"] = 13579968035,
    ["bouncin"] = 18986228959,
    ["peanutbutter jelly time"] = 10049457548,
    ["stock shuffle 2"] = 15039780593,
    ["hugo"] = 18502971000,
    ["expresso"] = 115573948686907,
    ["back on 74 static loop"] = 16928174772,
    ["barbi"] = 14340896214,
    ["ET"] = 17302883077,
    ["moongazer cafune"] = 135064031952812,
    ["Laufey from the start"] = 85444981015452,
    ["bubble gum 1 new jeans"] = 18331822907,
    ["bubble gum 2 new jeans"] = 18331893728,
    ["september - earth wind and fire"] = 15086356834,
    ["super shy pt 1"] = 18331640591,
    ["super shy pt2"] = 18331705911,
    ["alibi pt1"] = 18125236590,
    ["alibi pt2"] = 18319544101,
    ["alibi pt 3"] = 18639586999,
    ["beat it mj"] = 13842485756,
    ["peanut butter jelly time"] = 5803901179,
    ["Dice"] = 14846465116,
    ["Agassy"] = 15569359960,
    ["Wa Da Da"] = 17590216758,
    ["Samsara"] = 17483159067,
    ["fundy jig"] = 10724859471,
    ["chikiri bai bai"] = 140291985636707,
    ["Sugar Rush Ride"] = 16817943406,
    ["Vapu Vapu"] = 16995605441,
    ["Simpa V2"] = 12453892230,
    ["scenario"] = 8924083749,
    ["Bhangra Boogie"] = 108017084992975,
    ["Raining Tacos"] = 18996306719,
    ["Kaito Is An Alien"] = 18829447419,
    ["Sheesh"] = 16987826572,
    ["Tra Tra"] = 18231426297,
    ["Americano"] = 8601286610,
    ["Shoot!"] = 15954541522,
    ["YooHoo"] = 15795602834,
    ["Sickick Mind Games"] = 115672975245116,
    ["bubble gum 1 new jeans"] = 18331822907,
    ["Silent Hacker"] = 16826813658,
    ["Round 6"] = 86785215843177,
    ["NA"] = 131666011040524,
    ["goofy goober"] = 73981202280803,
    ["Drop It Like It's Hot"] = 15178362342,
    ["Hush Rush"] = 17743368730,
    ["GGUM"] = 131137139811722,
    ["Killing Me"] = 15926567988,
    ["Horizon"] = 16906389402,
    ["Endless Flow"] = 99816916718811,
    ["Typa Girl"] = 15786367515,
    ["Slide Now Now"] = 8230248004,
    ["bumble bee"] = 13964477190,
    ["Springy"] = 133890078327190,
    ["hug me more"] = 7042423417,
    ["Moongazer"] = 135064031952812,
    ["Hope"] = 15511861196,
    ["Starship ( nicki minaj )"] = 17598989892,
    ["Puppet Show"] = 15437172661,
    ["The Girls II"] = 14950069955,
    ["More & More"] = 15957779312,
    ["POP!"] = 15954524008,
    ["Macarena"] = 8917320260,
    ["Money trees"] = 14458875200,
    ["BrooklynBloodPop!"] = 15309391511,
    ["Kitty Cat MEME"] = 18121561293,
    ["Boney Bounce"] = 83470324180522,
    ["Hate Rodrigo"] = 14758497233,
    ["Planetary"] = 109054885000137,
    ["Tyla Dance"] = 18218681238,
    ["Poker Face II"] = 18710870010,
    ["oddloop"] = 18715249701,
    ["Funk do bounce"] = 132545638708993,
    ["Cash Dance"] = 7041113269,
    ["The Dogg"] = 108340529144175,
    ["Stranger"] = 16121568289,
    ["Loco"] = 14950828704,
    ["Cuff It ( Beyonce )"] = 11115365773,
    ["WiggleWiggle"] = 17439999314,
    ["calm down"] = 88277560473596,
    ["Make A Wish"] = 9355351062,
    ["Shawn Stitches"] = 130634896001082,
    ["5sec Youngblood"] = 109971524835248,
    ["I'm Bad"] = 18766790249,
    ["Money"] = 15088152079,
    ["Poppin' Shakin'"] = 17171828067,
    ["maria hwasa"] = 15489358017,
    ["Brooklyn pop"] = 17244348290,
    ["Go Mufasa (Fortnite)"] = 134887103409831,
    ["Not A Devil"] = 125983101461360,
    ["crank that"] = 7974313986,
    ["Bang"] = 15879246434,
    ["workit"] = 9395049509,
    ["Shut Down"] = 16817391887,
    ["How That Taste"] = 18651813895,
    ["Drive Me Crazy"] = 17353959998,
    ["Magnetic"] = 17078018782,
    ["Slum Anthem II"] = 17744858894,
    ["Shout"] = 16906627656,
    ["All Night"] = 16491251704,
    ["Heart 111"] = 18399954129,
    ["How You Like That II"] = 14204478463,
    ["I Am"] = 14758520223,
    ["Exclusive"] = 17068780580,
    ["LALISA"] = 15101980014,
    ["Mesmerizer (Miku) (TT Ver.)"] = 17640486421,
    ["Oh Shhh"] = 137052510169731,
    ["jerk off"] = 85510928563896,
    ["entranced"] = 18442013842,
    ["To The Moon"] = 94655045117804,
    ["Feelin' Jaunty"] = 136570900168732,
    ["Fast Feet"] = 80217482934917,
    ["LOVE AGAIN (The Kid LAROI)"] = 89422288168329,
    ["Go Mufasa"] = 134887103409831,
    ["In Da Party"] = 81251164590970,
    ["I Like To Move It"] = 127449912339458,
    ["I'm Out"] = 112938518545551,
    ["Wanna See Me"] = 132796690293567,
    ["The Dip"] = 129512349496854,
    ["Toosie Slide"] = 135788271145619,
    ["Barbi"] = 14340896214,
    ["Let It Out"] = 11822727177,
    ["Brooklyn Pop"] = 8763979029,
    ["hustla"] = 139569192211929,
    ["fishin (Fortnite)"] = 7305746986,
    ["ride the pony (Fortnite)"] = 9848532804,
    ["get Sturdier"] = 137959340008695,
    ["SturdyV2"] = 137959340008695,
    ["Gangnam V2"] = 8913898338,
    ["Jabba Loop V2"] = 8229514367,
    ["Love Me Like I Love You"] = 113197266804415,
    ["Smooth Criminal"] = 8036951540,
    ["The Worm Loop V2"] = 7160307855,
    ["Rude Boy II"] = 16827397883,
    ["Scream & Shout II"] = 16827533892,
    ["Slave To The Rhythm"] = 16827642962,
    ["Clothes"] = 16827238817,
    ["Bad Remix"] = 16906283522,
    ["HeavyDirtySoul"] = 16927471657,
    ["Heroes Tonight"] = 16927556629,
    ["Igaku"] = 16922809079,
    ["Runaway"] = 16927669445,
    ["Prince Of Egypt"] = 16906415457,
    ["Marikit Sa Dilim"] = 16906666026,
    ["Cure For Me"] = 16995704851,
    ["Having a Bath"] = 16995463809,
    ["Lay It Down II"] = 16986250768,
    ["Long Way 2 Go"] = 16989628401,
    ["No Doubt"] = 16988711502,
    ["Pajama Party Song"] = 16997154126,
    ["Stupid In Love"] = 16995583000,
    ["The Way I Are"] = 16987792033,
    ["Truth or Dare"] = 16988291254,
    ["Automotivo Satisfaction"] = 16986465327,
    ["ENOUGH!"] = 17102029049,
    ["Markiplier"] = 17101949137,
    ["Midnight Morning"] = 17080363745,
    ["Rabbit Hole"] = 17080368789,
    ["Take It"] = 17068852940,
    ["Tenge Tenge"] = 17069865343,
    ["Bad Boy"] = 15959913476,
    ["Have You Seen My Bf"] = 17519408697,
    ["Hit Me Up"] = 17514363987,
    ["I Win, You Lose"] = 17509887742,
    ["It's Gonna Be Me"] = 17505818113,
    ["Jelebi Baby"] = 17510005422,
    ["Bass Knight"] = 18236720385,
    ["Sequência Colocadão"] = 17512666760,
    ["She’s From The Island"] = 17494079141,
    ["Without Me"] = 1750587209,
    ["Better When I'm Dancin'"] = 17598991805,
    ["Carefree"] = 17589995043,
    ["Dancing With A Stranger"] = 17598086026,
    ["Don't Talk To Me"] = 17598993954,
    ["Good Night Lady"] = 17589330422,
    ["Hammer Time"] = 17589891310,
    ["Melbourne Shuffle"] = 17588925114,
    ["SWAG"] = 17741857313,
    ["Shake That Brass"] = 17591333595,
    ["The Posh Boy"] = 17591075030,
    ["Uptown Funk"] = 17669452796,
    ["Tacaca"] = 17669244192,
    ["Hey Ho"] = 17669297584,
    ["Gigantic O.T.N"] = 17509790527,
    ["Eu Sento Gabu!"] = 17658071387,
    ["I Like It"] = 17672349928,
    ["Con Con Cat"] = 17742298800,
    ["Dance therapy"] = 17753378250,
    ["Don't Worry"] = 17744212701,
    ["Let Me See You"] = 17744917114,
    ["Low"] = 17755523209,
    ["Luz Do Luar"] = 17743420847,
    ["Made In Romania"] = 17759349644,
    ["Mysterious Game"] = 17742094115,
    ["Oka Ramman"] = 17753542254,
    ["Buss It"] = 17745190428,
    ["BELLAKEO"] = 17837503282,
    ["Beautiful Liar"] = 17831045411,
    ["Bloodline"] = 17832109114,
    ["Dominó"] = 17842534573,
    ["Get Into It (Yuh) II"] = 17833304354,
    ["I Luv It"] = 17832763915,
    ["Incredible"] = 17835044374,
    ["PR FERIR"] = 17843957556,
    ["Worth It II"] = 17831097892,
    ["You Right"] = 17831711725,
    ["Ain't Your Mama"] = 17830768930,
    ["Ai Ai Ai Mega Prince"] = 18125672887,
    ["Ai He"] = 18121645911,
    ["Alibi II"] = 18319544101,
    ["Chihiro MTG"] = 18148386362,
    ["Double Team"] = 18125445041,
    ["Espresso"] = 18146564147,
    ["Espresso II"] = 18135222680,
    ["Gangsta"] = 18133641617,
    ["Helltaker"] = 18121692753,
    ["JumpStyle"] = 17858431097,
    ["Let's Do It Again"] = 18121579426,
    ["Nasty"] = 18148041233,
    ["Ui Mugibatake"] = 18147252039,
    ["Baby II"] = 18209522583,
    ["Baseline Bussiness"] = 18207659656,
    ["Bouncing G5"] = 18210900028,
    ["Ding Dong Song"] = 18246278810,
    ["I I I"] = 18232085181,
    ["La Pepo"] = 18219213495,
    ["MTG Last Night"] = 18218852741,
    ["Safer"] = 18218538613,
    ["Pumba Pumba"] = 18348715399,
    ["WISE"] = 18238999192,
    ["Company Jig"] = 18319231655,
    ["Diamonds & Pearls"] = 18348287674,
    ["Don't Go Insane"] = 18336940634,
    ["El gatito tuyo te perdio"] = 18347159703,
    ["Gucci Gucci"] = 18318203808,
    ["Pantropiko x Day & Night"] = 18332625539,
    ["Darling"] = 18432613302,
    ["De Yang Gatal Sa"] = 18443267622,
    ["Goodies"] = 134586304179871,
    ["La Mama"] = 18445553677,
    ["Like A Rodeo"] = 18447913072,
    ["Qinghai Shake"] = 18443420661,
    ["Tiramisu Cake"] = 18400161233,
    ["Tuca Tuca"] = 18443210308,
    ["5:20AM"] = 18441535557,
    ["9mm"] = 18319003563,
    ["Confident"] = 18443885876,
    ["Da Da Da II"] = 18546573714,
    ["Da Da Da Shuffle"] = 18546537798,
    ["Dancin' Domino"] = 18522791385,
    ["No Speak Americano"] = 18536691886,
    ["Point and Strut"] = 18532500355,
    ["Samba De Wasshoi!"] = 18532929480,
    ["The Squabble"] = 18553745388,
    ["Tucked"] = 18530609511,
    ["Dung Lam Trai"] = 18649048765,
    ["Giri Giri Dance"] = 18655870449,
    ["I Wanna Be Your follower"] = 18641984949,
    ["Meet at the next corner"] = 18648818158,
    ["Meme Funk"] = 18642062621,
    ["PAKU"] = 18648976965,
    ["Tell me"] = 18766916309,
    ["Back On 74"] = 18740645336,
    ["Been Like This"] = 18740994665,
    ["Dadadada Tenshi"] = 18710950115,
    ["GTA Dance"] = 18743035691,
    ["I Have Nothing To Say"] = 18725268714,
    ["Koi Dance"] = 18723607032,
    ["Lost In Paradise"] = 18724677202,
    ["Love Kyun Wanted"] = 18711007163,
    ["Mine"] = 124492610127985,
    ["Motteke Sailor Fuku"] = 18723463754,
    ["A Bar Song"] = 103000564408232,
    ["Rockabye"] = 18724951218,
    ["Swalla"] = 18740808703,
    ["Back It Up"] = 18846379978,
    ["Bye Bye Bye"] = 18836343559,
    ["FUNKED UP"] = 18863712729,
    ["Fine China"] = 18820121203,
    ["Gyatt For Nerizzler"] = 18845819589,
    ["HA-HA!"] = 18846103241,
    ["Hakari Dance"] = 18846734933,
    ["Heel Click"] = 18863706004,
    ["Japanese Phonk"] = 18862724630,
    ["Korean Cheerleader"] = 18829377057,
    ["Kuru Kuru Kururin"] = 18848216027,
    ["Ma Ma Ma II"] = 18846154606,
    ["Neko Kaburi Na"] = 18835807145,
    ["Sacabambaspis"] = 18834774168,
    ["Anima Power"] = 18959257871,
    ["Brites Moves"] = 18950197254,
    ["Evil Plan"] = 18863717493,
    ["Goated"] = 18969257806,
    ["Leaderboard"] = 137150638313235,
    ["Lunar Party"] = 119703033043179,
    ["Rollie"] = 139528127590899,
    ["Stay Up"] = 124500473772133,
    ["Swag Beat"] = 115733505136871,
    ["Tauba Tauba"] = 116578687414020,
    ["Timber1"] = 95495006115572,
    ["Bird Call"] = 116815789865803,
    ["Speed"] = 92687809152911,
    ["Big Dawgs"] = 84090608993841,
    ["Boing Swing"] = 83700935018360,
    ["Can Can"] = 123220715631267,
    ["Fast Flex"] = 110332761819297,
    ["Feel It"] = 131709887164498,
    ["Lo-fi"] = 96519329274556,
    ["Pulsebreaker"] = 129276303376319,
    ["Snake Groove"] = 92227709240709,
    ["Walkin' Pretty"] = 114254689551646,
    ["Without You"] = 77766747777549,
    ["After Hours"] = 105935327122803,
    ["Criss Cross"] = 83451553426933,
    ["Miley"] = 71785961342293,
    ["Hana"] = 86261625089100,
    ["Happy Dog"] = 110780464467650,
    ["His & Hers"] = 109871383329975,
    ["Jaywalking"] = 125238941692427,
    ["Shaq"] = 116805820449516,
    ["Smack Yo"] = 131474670923668,
    ["Spicy Start"] = 122507653814221,
    ["Theme song"] = 103889663436383,
    ["Alibi III"] = 18639586999,
    ["Philly Goats-Buckle Up"] = 91495711099103,
    ["ASmith-Dancin"] = 139782974681210,
    ["Blast Move"] = 80025649457203,
    ["Fast Fury"] = 130985777939088,
    ["Fierce Swag"] = 102877697069779,
    ["Gru Dance"] = 121765148647875,
    ["Maximum Bounce"] = 74084616150320,
    ["Night Out"] = 93771723828849,
    ["Smooth Slide"] = 89487756791952,
    ["Cheerleader2"] = 71252630434744,
    ["Doodle"] = 84463413551540,
    ["Leilt"] = 125395879083009,
    ["Malatanghulu2"] = 106868003915523,
    ["Slide Stride"] = 140603204775430,
    ["Sweet Shot"] = 133379233738041,
    ["APTv2"] = 133395265727090,
    ["Mamushi"] = 18845906101,
    ["Culture Festival"] = 132419238573831,
    ["Emergency2"] = 130675735022329,
    ["Mood"] = 98228401832445,
    ["PC24"] = 87214454379601,
    ["Pig Dance"] = 138988330656366,
    ["john-Traffic"] = 71894922167975,
    ["h3R3-MissYou"] = 133109803473958,
    ["Amaarae-Luv Money"] = 122157693129395,
    ["Hiiragi-Tetoris"] = 125058040803530,
    ["Batte Forte"] = 102060121134651,
    ["Ask Me"] = 135228282276469,
    ["Halloween Beast"] = 12540868623,
    ["I Ain't Afraid"] = 81315214408244,
    ["Monster Mash"] = 75657221755215,
    ["Pump It Up"] = 107556241253371,
    ["Reanimated1"] = 98469545127257,
    ["Fright Funk1"] = 83544638023597,
    ["Hot To Go"] = 85267023718407,
    ["Bad Guy1"] = 77288355613525,
    ["Carolina"] = 78673618409072,
    ["Debochada"] = 76463210365083,
    ["Dream Feet"] = 72705907144448,
    ["Lazer Blast"] = 107994227175066,
    ["MAITAKE"] = 93130440754306,
    ["Moonlit"] = 81834617503414,
    ["Gangnam"] = 80398743560629,
    ["Granada"] = 78293994761172,
    ["Arona"] = 116975656514108,
    ["Pop In 2"] = 123702667366431,
    ["Run"] = 91085526067649,
    ["Shiitake"] = 129227624624368,
    ["Snoop Walk"] = 132477655284495,
    ["Take it Slow"] = 100551198874005,
    ["smaSher-Empurra"] = 137091690757651,
    ["Veggie"] = 132295464457565,
    ["Chaos"] = 72779334811742,
    ["Bunny Girl"] = 135330413860391,
    ["NINA-Move Ya Body"] = 109551168484965,
    ["Desirable"] = 108818394598530,
    ["FAERIE"] = 127885017128720,
    ["Make Me"] = 140183892184019,
    ["Kashii-Cat Loving"] = 126746495297624,
    ["Blanktape-Turuan"] = 132716888916327,
    ["BrunoM-Bonde"] = 82716852623277,
    ["DJHard-Bashi Bashi"] = 115798738289130,
    ["GDRAGON-POWER"] = 83561852796756,
    ["JJ Lin-No Money"] = 99637974405359,
    ["CharlieP-Dont Talk"] = 94461583739254,
    ["Oruam-TROPA DO ORUAM"] = 107591803417714,
    ["Zachz-guli"] = 71078330743706,
    ["El Alfa-ESTE"] = 138723007840035,
    ["HEARTSTEEL-Paranoia"] = 136926335172781,
    ["Lojay-Monalisa"] = 109905892550009,
    ["SoMo-50Feet"] = 115380505264488,
    ["TruththeBull-HYPE ME UP"] = 139400505174036,
    ["Village People-YMCA"] = 78742010701451,
    ["BB Belt"] = 79541061032796,
    ["YOASOBI-UNDEAD"] = 109658950870605,
    ["Something Sweet"] = 117011995366745,
    ["Rich-Tapout"] = 102480130402269,
    ["NiziU-Make Happy"] = 107018845763813,
    ["BUMBAA"] = 90779822053049,
    ["Bed Chem"] = 70614062353518,
    ["Did It First"] = 104924566284253,
    ["Nomi-BLAH"] = 76529954844846,
    ["Problem2"] = 102637131613028,
    ["Embrace It"] = 72117290471362,
    ["KEEP UP"] = 80586234339889,
    ["Ariana-No Tears"] = 112734209857887,
    ["JT-SwagBack"] = 95939066860595,
    ["Happy (Prod. Hedyy)"] = 18953456970,
    ["Last Forever"] = 18863701920,
    ["Looking Good"] = 18863697075,
    ["See Me In A Crown"] = 18973179163,
    ["Shake It Off"] = 18952701833,
    ["Soltando Pancadão"] = 18972490730,
    ["Suki Suki Suki"] = 18946025428,
    ["São Amores"] = 18952949480,
    ["Uchida 1"] = 18945973328,
    ["Your Number"] = 18953075358,
    ["Apple Dance 2"] = 18946844622,
    ["As Long As You Huat"] = 18998207468,
    ["Bag Work"] = 123725130872798,
    ["ArianaG-Last Christmas"] = 130115633688469,
    ["Champ's Clap"] = 18995451918,
    ["Element"] = 18995977824,
    ["Independence"] = 19003847439,
    ["Lights Out"] = 18998437001,
    ["Oki Doki"] = 18993544375,
    ["Splash Damage"] = 18995334538,
    ["Ta Ta Ta"] = 75826066577908,
    ["Dancery"] = 139819388139667,
    ["MariahC-Want 4 xmas"] = 15569415780,
    ["Fantasy Faceoff"] = 136282125273244,
    ["Jiggle Jiggle"] = 103720979881624,
    ["Jumpshot"] = 98925895870667,
    ["Baby Mama"] = 99110766306643,
    ["Outlaw"] = 82746341617847,
    ["Ta Ta Ta 2"] = 91368017589759,
    ["Handshake"] = 71243990877913,
    ["Stay Style"] = 93328147373779,
    ["Challenge"] = 83923307400471,
    ["Classy"] = 78428472180235,
    ["Don't Cha"] = 98588383635359,
    ["Forget Me Not"] = 119574283368193,
    ["Jubi Slide"] = 98252061243403,
    ["Triste com T"] = 124604199171592,
    ["Line Dancin"] = 101369357281876,
    ["Miruni"] = 87617771479225,
    ["Perfect Score"] = 139292073803836,
    ["Pocket Locket"] = 128618231080047,
    ["Real Slim Shady"] = 101228736701257,
    ["Red1"] = 105435600557305,
    ["Shimmy Wiggle"] = 76082795493886,
    ["Show Ya"] = 108448532674168,
    ["The Dance LAROI"] = 75239905741750,
    ["The Quick Style"] = 103847619627425,
    ["Chihiro2"] = 134841267819107,
    ["Cradles1"] = 132180762791625,
    ["Deep Explorer"] = 99986218616988,
    ["Fast Car"] = 124458006316301,
    ["Halfway"] = 71475729633697,
    ["In My Bed"] = 111991313205546,
    ["Just Know1"] = 72713542992987,
    ["Pogba-Ela joga"] = 126871800781728,
    ["Tyler-Sticky2"] = 134909729564479,
    ["BM-WithSmile"] = 111205373680745,
    ["RinV-Good"] = 97064449863633,
    ["GINTA-KAMASE"] = 109039162634965,
    ["Netflix-Mingle2"] = 126736330036532,
    ["DJRUINA-Bear"] = 125909896768791,
    ["Cake II"] = 14711370865,
    ["Solo"] = 14907680676,
    ["ASAP"] = 9183680092,
    ["ANTIFRAGILE"] = 15178352490,
    ["Action"] = 15437674680,
    ["Adios"] = 15183462851,
    ["Alcohol-Free"] = 15507151401,
    ["Anpanman"] = 15507627471,
    ["I'll Show You"] = 15634516315,
    ["Drama"] = 15569498104,
    ["Dolphin"] = 15634547372,
    ["Abracadabra"] = 14957258734,
    ["All Eyes On Me"] = 15104893350,
    ["BBUSYEO"] = 9991485864,
    ["BBoom BBoom"] = 12008828114,
    ["Baby Don't Stop"] = 15086711293,
    ["Back In Vogue"] = 15178366587,
    ["Baddie"] = 15254578171,
    ["Batter Up"] = 15553568636,
    ["Blah Blah Blah"] = 14648343355,
    ["Pretty Savage"] = 17164801888,
    ["Boom"] = 15569628760,
    ["Boombayah"] = 15254273286,
    ["Bouncy"] = 14143674954,
    ["Boy With Luv"] = 13361878864,
    ["Igloo"] = 72705631233287,
    ["Charmer"] = 14456520068,
    ["Cheshire"] = 14845155835,
    ["Chili"] = 15306601096,
    ["Converse High"] = 15569468810,
    ["Cry For Me"] = 14958064290,
    ["Cupid Dance"] = 14458761918,
    ["DDARA"] = 15745877593,
    ["DEEP"] = 14456866502,
    ["Next Level"] = 73666718896602,
    ["Dance The Night Away"] = 15437651094,
    ["Deja vù"] = 15746540104,
    ["Ditto"] = 14306647474,
    ["Do Not Touch"] = 15428845859,
    ["Doughnut"] = 15254341227,
    ["Dreams Come"] = 9249771813,
    ["Drunk-Dazed"] = 15746942410,
    ["Dumb Dumb"] = 15747119564,
    ["BTBT"] = 11562114786,
    ["IVE-Supernova Love"] = 136917630185596,
    ["Breakthrough"] = 15710888621,
    ["Dancing King"] = 15710689397,
    ["Dream Of You"] = 15701655961,
    ["Fingertip"] = 15710794282,
    ["Get It"] = 15710919135,
    ["Like OOH-AHH"] = 15711239792,
    ["So Hot"] = 15706683049,
    ["Eunoia"] = 13006438318,
    ["Eve, Psyche & BW"] = 14143553486,
    ["Fancy"] = 15254438022,
    ["Fast Forward"] = 15103490862,
    ["Fearless"] = 9604542135,
    ["Fire"] = 10297929371,
    ["Flowers"] = 14360321360,
    ["GGBB"] = 14758568953,
    ["Galileo"] = 15254328512,
    ["Peek-A-Boo"] = 17188208710,
    ["GingaMingaYo"] = 12168640144,
    ["Go Big or Go Home"] = 15178354473,
    ["Go Hard"] = 14840759624,
    ["Ready For Love"] = 110272002917472,
    ["Grl Gvng"] = 15314684858,
    ["Guerrilla"] = 15427967206,
    ["Gum"] = 15319042831,
    ["Whiplash"] = 84761716541897,
    ["Red Lights1"] = 79483595485043,
    ["Filter"] = 15769956533,
    ["Crazy Form"] = 15770022100,
    ["Attention"] = 15786493717,
    ["SKZ-Giant"] = 82086620169755,
    ["HIT YA!"] = 14648380354,
    ["Airplane pt 2"] = 17175043979,
    ["Hope World"] = 17832909398,
    ["Hula Hoop"] = 12168870616,
    ["Fate"] = 17068636413,
    ["Hype Boy"] = 14690505486,
    ["I Can't Stop Me"] = 15437508723,
    ["I Love My Body"] = 15044170099,
    ["INVU"] = 14709181461,
    ["LOSER=LOVER"] = 14884131961,
    ["Impurities"] = 15252093658,
    ["Cake"] = 14758473677,
    ["Ringo"] = 14977014999,
    ["The Idol"] = 14709052794,
    ["More"] = 15926531281,
    ["Look At Me"] = 17069753179,
    ["Mysterious"] = 15880335321,
    ["New Dance"] = 15880457949,
    ["None of My Business"] = 15880405184,
    ["Candy Pop"] = 15954541522,
    ["Kitsch"] = 15957486812,
    ["Scientist"] = 15957626186,
    ["Moonlight"] = 14360382400,
    ["Lion"] = 15178359180,
    ["Like Crazy"] = 17243081974,
    ["Chk Chk Boom 2"] = 89053989634034,
    ["Love Me Like This"] = 15254167229,
    ["Love Shot"] = 15042011356,
    ["Lovesick Girl"] = 14337920126,
    ["NEW WOMAN"] = 131721216910827,
    ["Megaverse"] = 15431172216,
    ["Mc Chicken Dance"] = 14709031676,
    ["Starry Night"] = 82009339442151,
    ["My Name V"] = 10783558665,
    ["Mash Up"] = 14649333000,
    ["My Bag"] = 15996204502,
    ["Naughty Boy"] = 15569786978,
    ["OMG"] = 14360424066,
    ["Nxde"] = 16005012294,
    ["Nobody"] = 15504654082,
    ["New Jeans"] = 14907708508,
    ["One More Time"] = 15316785104,
    ["Pandora"] = 15995791226,
    ["My Pace"] = 16089778475,
    ["Me (Rap)"] = 16121871257,
    ["Love Love Love"] = 16120595987,
    ["Hold On Tight"] = 16020395771,
    ["Yes or Yes"] = 15957562949,
    ["Chase Love Hard"] = 16214805483,
    ["UP4"] = 117605822363146,
    ["TT"] = 16492220339,
    ["Soñar"] = 16302177686,
    ["Maria"] = 16302946151,
    ["Love Dive"] = 16299894030,
    ["Crazy Over You"] = 16302880378,
    ["Debut"] = 102726205399656,
    ["Better Things"] = 16423848646,
    ["Fact Check"] = 16423407915,
    ["Russian Roulette"] = 16388655889,
    ["Kill This Love 2"] = 16491833044,
    ["Untouchable II"] = 16302111242,
    ["Wife"] = 16388628018,
    ["Super Lady"] = 16302081447,
    ["Candy"] = 16582854299,
    ["Not Shy"] = 16582998069,
    ["Spring Day"] = 16582791937,
    ["I'm not cool"] = 16671546299,
    ["Log in"] = 16669666941,
    ["Perfect Night"] = 15422072504,
    ["Pink Venom"] = 14360487641,
    ["Pirate"] = 9577608405,
    ["Poppy"] = 14913019144,
    ["Pose"] = 15437793544,
    ["Easy"] = 16755161447,
    ["Maniac 2"] = 16826050749,
    ["Queencard"] = 14390206440,
    ["Ring The Alarm"] = 15104827793,
    ["Ring x Ring"] = 15507689525,
    ["Roly Poly"] = 16120658006,
    ["Rose"] = 12977552708,
    ["TTYL"] = 70816579313825,
    ["CRAZY 2"] = 79445566802891,
    ["SG"] = 9715503915,
    ["Seven"] = 14390424694,
    ["Seven 2"] = 16817182259,
    ["Shooting Stars"] = 12871295658,
    ["Paint The Town"] = 17079779758,
    ["Set Me Free"] = 15432823630,
    ["Slay"] = 14811111697,
    ["Snake"] = 9604765491,
    ["Sneakers"] = 12138500641,
    ["Social Path"] = 14950111063,
    ["Spicy"] = 14230856023,
    ["Sweet Crazy Love"] = 12977606310,
    ["Super Tuna"] = 17833000129,
    ["Super Shy"] = 15357058625,
    ["Sugar"] = 16817904771,
    ["Run Away1"] = 135670294474657,
    ["Baam"] = 16826181626,
    ["Thirsty"] = 16906160228,
    ["Very Nice"] = 16924724555,
    ["Smart"] = 16925912001,
    ["Q&A"] = 16995826438,
    ["Playing With Fire"] = 16995558532,
    ["Armageddon"] = 18863495250,
    ["Win"] = 17079972610,
    ["Royal"] = 17068825635,
    ["Magnetic II"] = 17353634431,
    ["Young, Dumb, Stupid"] = 17266568423,
    ["Purr"] = 17243669137,
    ["Nobody Knows"] = 17266485887,
    ["Mirotic"] = 17362134841,
    ["JJAM"] = 128058242953208,
    ["Midas Touch"] = 17362739079,
    ["Crazy"] = 17353843330,
    ["Before U Go"] = 17353745726,
    ["Blue Bood"] = 17437097964,
    ["Chicken Noodle Soup"] = 17446635891,
    ["HEYA"] = 17439113373,
    ["Sheesh II"] = 17439802258,
    ["Talk That Talk"] = 15053175546,
    ["TGIF"] = 15044143466,
    ["TOMBOY"] = 17558055394,
    ["The Girls"] = 14745099838,
    ["The Eve"] = 15314740242,
    ["That That"] = 9577219971,
    ["The Black Cat Nero"] = 15042534606,
    ["WaveWay"] = 124625882154906,
    ["TIKI TAKA"] = 17560001332,
    ["Top Or Cliff"] = 15109594086,
    ["Typa Girl (Intro)"] = 14690394983,
    ["Unforgiven"] = 14354058855,
    ["Vengeance"] = 17567602391,
    ["Tinnitus"] = 13539158026,
    ["woo!ah!"] = 14690438699,
    ["World"] = 15178283482,
    ["Xoxo"] = 15569894153,
    ["ZOO"] = 14287825206,
    ["Woman II"] = 9183689189,
    ["Wannabe II"] = 14908291589,
    ["Lucky Girl Syndrome"] = 17518983536,
    ["Supernova"] = 17509367733,
    ["Zoom"] = 17589910939,
    ["Oh my god"] = 17509688608,
    ["Permission To Dance"] = 17659577567,
    ["Impossible"] = 17589061583,
    ["Accendio"] = 17659639868,
    ["Bad Reputation"] = 17772959723,
    ["KISS"] = 17769582250,
    ["The Boots"] = 17832398448,
    ["UP&DOWN"] = 17830998987,
    ["Move"] = 17831074021,
    ["How Sweet"] = 17846925892,
    ["HIP"] = 17832633275,
    ["How Sweet - pt2"] = 18331481588,
    ["Pop Like This"] = 18319061287,
    ["Megan-That Style"] = 118244079190674,
    ["LK-Oncinhas"] = 75419590211428,
    ["Tobii-Bad Girls"] = 85827618059547,
    ["APTs"] = 108794829512642,
    ["Sage-GasPedal"] = 136751837272445,
    ["2Pac-Want it"] = 78088451215023,
    ["Maps"] = 138580335785363,
    ["Leat-Nya Arigato2"] = 138814469709630,
    ["Million Dollar Baby"] = 17512824075,
    ["Netflix-Mingle"] = 138292957837319,
    ["Tyla-PUSH 2"] = 122397638290852,
    ["Don-No Pole"] = 77504522238611,
    ["MichaelPrince-Finesse"] = 118856249569207,
    ["Tyler-Sticky"] = 82591052342579,
    ["7dnight-Gwenchana"] = 133834197390854,
    ["SeanK-Beat It"] = 72963340508086,
    ["djlox-Throat"] = 84405181207305,
    ["Wannabe"] = 14837885432,
    ["Just Dance"] = 14797631924,
    ["Ashley, look at me!"] = 14372354950,
    ["Muerto Gang"] = 14629687441,
    ["Cha Cha Cha"] = 15041933237,
    ["Simple Dimple"] = 15103561717,
    ["September"] = 15086356834,
    ["Me too"] = 15095853911,
    ["Hey Now"] = 15086240204,
    ["Faded Shuffle"] = 15065451084,
    ["Dusk Till Dawn"] = 15086714992,
    ["Coincidance"] = 15103592543,
    ["How Sweet - pt2"] = 18331463874,
    ["GANGNAM STYLE"] = 18553011864,
    ["SLIM SHADY"] = 18553150120,
    ["SNOOP’S WALK"] = 132477655284495,
    ["BEAT IT (MJ)"] = 138424855756,
    ["JAYWALKING"] = 10970927618,
    ["WORM"] = 7160307855,
    ["GTA"] = 18743035691,
    ["SPIDER-MAN"] = 8228461600,
    ["MONSTER SHUFFLE"] = 9249757736,
    ["beggin"] = 14052940722,
    ["heel toe toprock"] = 14053176456,
    ["dumb feet"] = 14053155061,
    ["kazotsky kick"] = 14053223573,
    ["im diamond"] = 14053214985,
    ["last forever"] = 14053226316,
    ["raise the roof"] = 14053240024,
    ["conga2"] = 14053147989
}

local newAnimations = {
    ["twerking"] = 91014640753525,
    ["Wait love me like  I love you"] = 113197266804415,
    ["head banger (fortnite)"] = 117390128696430,
    ["egg dance ( acu saya)"] = 14765075073,
    ["nya arigato"] = 16038410193,
    ["move ya body"] = 109551168484965,
    ["hug"] = 113001288211277,
    ["push 2 start"] = 121825287394407,
    ["jumpstyle"] = 127818220981023,
    ["kiss"] = 130415689601813,
    ["jerk off"] = 85510928563896,
    ["backshots"] = 107788763755159,
}

local existingIds = {}
for _, id in pairs(BuiltInAnimationsR15) do
    existingIds[id] = true
end

for animName, animId in pairs(newAnimations) do
    if not existingIds[animId] then
        BuiltInAnimationsR15[animName] = animId
        print("Added animation:", animName, "with ID:", animId)
    else
        print("Duplicate animation ID found, skipping:", animName, "with ID:", animId)
    end
end

local favoriteAnimations = {}
local animationKeybinds = {}

local function saveFavorites()
    local success, encodedFavorites = pcall(HttpService:JSONEncode(favoriteAnimations))
    if success then
        local saveSuccess, errorMessage = pcall(function()
            writefile("favorite_animations.json", encodedFavorites)
        end)
        if not saveSuccess then
            warn("Error saving favorites:", errorMessage)
        end
    else
        warn("Error encoding favorites:", encodedFavorites)
    end
end

local function loadFavorites()
    local success, fileContent = pcall(readfile, "favorite_animations.json")
    if success then
        local decodeSuccess, decodedFavorites = pcall(HttpService:JSONDecode(fileContent))
        if decodeSuccess and typeof(decodedFavorites) == "table" then
            favoriteAnimations = decodedFavorites
            print("Favorites loaded successfully.")
        else
            warn("Error decoding favorites:", decodedFavorites)
            favoriteAnimations = {}
        end
    else
        warn("No favorites file found, starting with empty favorites:", fileContent)
        favoriteAnimations = {}
    end
end

local function saveKeybinds()
    local keybindsToSave = {}
    for animName, keyCode in pairs(animationKeybinds) do
        keybindsToSave[animName] = keyCode.Name
    end
    local success, encodedKeybinds = pcall(HttpService:JSONEncode(keybindsToSave))
    if success then
        local saveSuccess, errorMessage = pcall(function()
            writefile("animation_keybinds.json", encodedKeybinds)
        end)
        if not saveSuccess then
            warn("Error saving keybinds:", errorMessage)
        end
    else
        warn("Error encoding keybinds:", encodedKeybinds)
    end
end

local function loadKeybinds()
    local success, fileContent = pcall(readfile, "animation_keybinds.json")
    if success then
        local decodeSuccess, decodedKeybinds = pcall(HttpService:JSONDecode(fileContent))
        if decodeSuccess and typeof(decodedKeybinds) == "table" then
            for animName, keyName in pairs(decodedKeybinds) do
                animationKeybinds[animName] = Enum.KeyCode[keyName]
            end
            print("Keybinds loaded successfully.")
        else
            warn("Error decoding keybinds:", decodedKeybinds)
            animationKeybinds = {}
        end
    else
        warn("No keybinds file found, starting with empty keybinds:", fileContent)
        animationKeybinds = {}
    end
end

local function scaleCFrame(cf, scale)
    local pos = cf.Position * scale
    local xRot, yRot, zRot = cf:ToEulerAnglesXYZ()
    return CFrame.new(pos) * CFrame.Angles(xRot, yRot, zRot)
end

local function adjustCloneToGround(clone)
    if not clone then return end
    local lowestY = math.huge
    for _, part in ipairs(clone:GetDescendants()) do
        if part:IsA("BasePart") then
            local bottomY = part.Position.Y - (part.Size.Y / 2)
            if bottomY < lowestY then
                lowestY = bottomY
            end
        end
    end
    local groundY = 0
    local offset = groundY - lowestY
    if offset > 0 then
        if clone.PrimaryPart then
            clone:SetPrimaryPartCFrame(clone.PrimaryPart.CFrame + Vector3.new(0, offset, 0))
        else
            clone:TranslateBy(Vector3.new(0, offset, 0))
        end
    end
end

local preservedGuis = {}
local function preserveGuis()
    local playerGui = LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
    if playerGui then
        for _, gui in ipairs(playerGui:GetChildren()) do
            if gui:IsA("ScreenGui") and gui.ResetOnSpawn then
                table.insert(preservedGuis, gui)
                gui.ResetOnSpawn = false
            end
        end
    end
end

local function restoreGuis()
    for _, gui in ipairs(preservedGuis) do
        gui.ResetOnSpawn = true
    end
    table.clear(preservedGuis)
end

local function updateCloneScale()
    if not ghostClone then return end
    for part, origSize in pairs(ghostOriginalSizes) do
        if part and part:IsA("BasePart") then
            part.Size = Vector3.new(origSize.X * cloneSize * cloneWidth, origSize.Y * cloneSize, origSize.Z * cloneSize)
        end
    end
    for motor, orig in pairs(ghostOriginalMotorCFrames) do
        if motor and motor:IsA("Motor6D") then
            local c0 = orig.C0
            local c1 = orig.C1
            local newC0 = CFrame.new(
                c0.Position.X * cloneSize * cloneWidth,
                c0.Position.Y * cloneSize,
                c0.Position.Z * cloneSize
            ) * CFrame.Angles(c0:ToEulerAnglesXYZ())
            local newC1 = CFrame.new(
                c1.Position.X * cloneSize * cloneWidth,
                c1.Position.Y * cloneSize,
                c1.Position.Z * cloneSize
            ) * CFrame.Angles(c1:ToEulerAnglesXYZ())
            motor.C0 = newC0
            motor.C1 = newC1
        end
    end

    local ghostHumanoid = ghostClone:FindFirstChildWhichIsA("Humanoid")
    if ghostHumanoid and ghostOriginalHipHeight then
        ghostHumanoid.HipHeight = ghostOriginalHipHeight * cloneSize
    end

    adjustCloneToGround(ghostClone)
end

local function updateCloneTransparency()
    if not ghostClone then return end
    for _, part in pairs(ghostClone:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = 1
        end
    end
    local head = ghostClone:FindFirstChild("Head")
    if head then
        for _, child in ipairs(head:GetChildren()) do
            if child:IsA("Decal") then
                child.Transparency = 1
            end
        end
    end
end

local function updateRagdolledParts()
    if not ghostEnabled or not originalCharacter or not ghostClone then return end
    for _, partName in ipairs(body_parts) do
        local originalPart = originalCharacter:FindFirstChild(partName)
        local clonePart = ghostClone:FindFirstChild(partName)
        if originalPart and clonePart then
            originalPart.CFrame = clonePart.CFrame
            originalPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            originalPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        end
    end
end

local function setGhostEnabled(newState)
    ghostEnabled = newState

    if ghostEnabled then
        local char = LocalPlayer.Character
        if not char then
            warn("No character found!")
            return
        end

        local humanoid = char:FindFirstChildWhichIsA("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        if not humanoid or not root then
            warn("Character is missing either Humanoid or HumanoidRootPart!")
            return
        end

        originalCharacter = char
        originalCFrame = root.CFrame

        char.Archivable = true
        ghostClone = char:Clone()
        char.Archivable = false

        local originalName = originalCharacter.Name
        ghostClone.Name = originalName .. "_clone"

        local ghostHumanoid = ghostClone:FindFirstChildWhichIsA("Humanoid")
        if ghostHumanoid then
            ghostHumanoid.DisplayName = originalName .. "_clone"
            ghostOriginalHipHeight = ghostHumanoid.HipHeight
        end

        if not ghostClone.PrimaryPart then
            local hrp = ghostClone:FindFirstChild("HumanoidRootPart")
            if hrp then
                ghostClone.PrimaryPart = hrp
            end
        end

        for _, part in ipairs(ghostClone:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 1
            end
        end
        local head = ghostClone:FindFirstChild("Head")
        if head then
            for _, child in ipairs(head:GetChildren()) do
                if child:IsA("Decal") then
                    child.Transparency = 1
                end
            end
        end

        ghostOriginalSizes = {}
        ghostOriginalMotorCFrames = {}
        for _, desc in ipairs(ghostClone:GetDescendants()) do
            if desc:IsA("BasePart") then
                ghostOriginalSizes[desc] = desc.Size
            elseif desc:IsA("Motor6D") then
                ghostOriginalMotorCFrames[desc] = { C0 = desc.C0, C1 = desc.C1 }
            end
        end

        if cloneSize ~= 1 or cloneWidth ~= 1 then
            updateCloneScale()
        end

        local animate = originalCharacter:FindFirstChild("Animate")
        if animate then
            originalAnimateScript = animate
            originalAnimateScript.Disabled = true
            originalAnimateScript.Parent = ghostClone
        end

        preserveGuis()
        ghostClone.Parent = originalCharacter.Parent

        adjustCloneToGround(ghostClone)

        LocalPlayer.Character = ghostClone
        if ghostHumanoid then
            Workspace.CurrentCamera.CameraSubject = ghostHumanoid
        end
        restoreGuis()

        if originalAnimateScript then
            originalAnimateScript.Disabled = false
        end

        task.delay(0, function()
            if not ghostEnabled then return end
            ReplicatedStorage.RagdollEvent:FireServer()
            task.delay(0, function()
                if not ghostEnabled then return end
                if updateConnection then updateConnection:Disconnect() end
                updateConnection = RunService.Heartbeat:Connect(updateRagdolledParts)
            end)
        end)

    else
        if updateConnection then
            updateConnection:Disconnect()
            updateConnection = nil
        end

        if not originalCharacter or not ghostClone then return end

        for i = 1, 3 do
            ReplicatedStorage.UnragdollEvent:FireServer()
            task.wait(0.1)
        end

        local origRoot = originalCharacter:FindFirstChild("HumanoidRootPart")
        local ghostRoot = ghostClone:FindFirstChild("HumanoidRootPart")
        local targetCFrame = ghostRoot and ghostRoot.CFrame or originalCFrame

        local animate = ghostClone:FindFirstChild("Animate")
        if animate then
            animate.Disabled = true
            animate.Parent = originalCharacter
        end

        ghostClone:Destroy()

        if origRoot then
            origRoot.CFrame = targetCFrame
        end

        local origHumanoid = originalCharacter:FindFirstChildWhichIsA("Humanoid")
        preserveGuis()
        LocalPlayer.Character = originalCharacter
        if origHumanoid then
            Workspace.CurrentCamera.CameraSubject = origHumanoid
        end
        restoreGuis()

        if animate then
            task.wait(0.1)
            animate.Disabled = false
        end

        cloneSize = 1
        cloneWidth = 1
    end
end

local fakeAnimStop
local function stopFakeAnimation()
    fakeAnimStop = true
    fakeAnimRunning = false
    for i,script in pairs(ghostClone:GetChildren()) do
        if script:IsA("LocalScript") and script.Enabled == false then
            script.Enabled=true
        end
    end

    if ghostClone then
        for motor, orig in pairs(ghostOriginalMotorCFrames) do
            if motor and motor:IsA("Motor6D") then
                motor.C0 = orig.C0
                motor.C1 = orig.C1
            end
        end

        for _, partName in ipairs(body_parts) do
            local part = ghostClone:FindFirstChild(partName)
            if part and part:IsA("BasePart") then
                part.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                part.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            end
        end
    end
end

local fakeAnimRunning = false
fakeAnimStop = false
local fakeAnimSpeed = 1
local function playFakeAnimation(animationId)
    if not ghostClone then
        warn("No fake character available!")
        return
    end
    if animationId == "" then return end
    if fakeAnimRunning then
        stopFakeAnimation()
    end
    wait(0.1)
    cloneSize = 1
    cloneWidth = 1    updateCloneScale()

    for motor, orig in pairs(ghostOriginalMotorCFrames) do
        motor.C0 = orig.C0
    end

    local success, NeededAssets = pcall(function()
        return game:GetObjects("rbxassetid://" .. animationId)[1]
    end)
    if not success or not NeededAssets then
        warn("Invalid Animation ID.")
        return
    end

    local character = ghostClone
    local rootPart = character:WaitForChild("HumanoidRootPart")
    local head = character:WaitForChild("Head")
    local leftFoot = character:WaitForChild("LeftFoot")
    local leftHand = character:WaitForChild("LeftHand")
    local leftLowerArm = character:WaitForChild("LeftLowerArm")
    local leftLowerLeg = character:WaitForChild("LeftLowerLeg")
    local leftUpperArm = character:WaitForChild("LeftUpperArm")
    local leftUpperLeg = character:WaitForChild("LeftUpperLeg")
    local lowerTorso = character:WaitForChild("LowerTorso")
    local rightFoot = character:WaitForChild("RightFoot")
    local rightHand = character:WaitForChild("RightHand")
    local rightLowerArm = character:WaitForChild("RightLowerArm")
    local rightLowerLeg = character:WaitForChild("RightLowerLeg")
    local rightUpperArm = character:WaitForChild("RightUpperArm")
    local rightUpperLeg = character:WaitForChild("RightUpperLeg")
    local upperTorso = character:WaitForChild("UpperTorso")

    local Joints = {
        ["Torso"] = rootPart:FindFirstChild("RootJoint"),
        ["Head"] = head:FindFirstChild("Neck"),
        ["LeftUpperArm"] = leftUpperArm:FindFirstChild("LeftShoulder"),
        ["RightUpperArm"] = rightUpperArm:FindFirstChild("RightShoulder"),
        ["LeftUpperLeg"] = leftUpperLeg:FindFirstChild("LeftHip"),
        ["RightUpperLeg"] = rightUpperLeg:FindFirstChild("RightHip"),
        ["LeftFoot"] = leftFoot:FindFirstChild("LeftAnkle"),
        ["RightFoot"] = rightFoot:FindFirstChild("RightAnkle"),
        ["LeftHand"] = leftHand:FindFirstChild("LeftWrist"),
        ["RightHand"] = rightHand:FindFirstChild("RightWrist"),
        ["LeftLowerArm"] = leftLowerArm:FindFirstChild("LeftElbow"),
        ["RightLowerArm"] = rightLowerArm:FindFirstChild("RightElbow"),
        ["LeftLowerLeg"] = leftLowerLeg:FindFirstChild("LeftKnee"),
        ["RightLowerLeg"] = rightLowerLeg:FindFirstChild("RightKnee"),
        ["LowerTorso"] = lowerTorso:FindFirstChild("Root"),
        ["UpperTorso"] = upperTorso:FindFirstChild("Waist"),
    }
    fakeAnimStop = false
    fakeAnimRunning = true
local part = Instance.new("Part")
part.Size = Vector3.new(2048,0.1,2048)
part.Anchored = true
part.Position = game.Players.LocalPlayer.Character.LowerTorso.Position + Vector3.new(0,-0.2,0)
part.Transparency = 1
part.Parent = workspace
game.Players.LocalPlayer.Character.Humanoid.PlatformStand = true
wait(0.1)
for i,script in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
    if script:IsA("LocalScript") and script.Enabled then
        script.Enabled=false
    end
end
game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
part:Destroy()
    spawn(function()
        while fakeAnimRunning do
            if fakeAnimStop then
                fakeAnimRunning = false
                break
            end

            local keyframes = NeededAssets:GetKeyframes()
            for ii, frame in pairs(keyframes) do
                if fakeAnimStop then break end

                if ii < #keyframes then
                    local nextFrame = keyframes[ii + 1]
                    local waitTime = (nextFrame.Time - frame.Time) / fakeAnimSpeed

                    for _, v in pairs(frame:GetDescendants()) do
                        local motor = Joints[v.Name]
                        if motor and ghostOriginalMotorCFrames[motor] then
                            motor.C0 = ghostOriginalMotorCFrames[motor].C0 * v.CFrame
                        end
                    end

                    task.wait(waitTime)
                else
                    -- For the last frame, just apply it
                    for _, v in pairs(frame:GetDescendants()) do
                        local motor = Joints[v.Name]
                        if motor and ghostOriginalMotorCFrames[motor] then
                            motor.C0 = ghostOriginalMotorCFrames[motor].C0 * v.CFrame
                        end
                    end
                end
            end

            task.wait(1 / 30)
        end
    end)
end

local function updateKeybindButtonText(animButtonData, animName)
    local keybind = animationKeybinds[animName]
    if keybind then
        animButtonData.KeybindButton.Text = keybind.Name
    else
        animButtonData.KeybindButton.Text = "Key"
    end
end

local function createAnimationListGui(animTextBox)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AnimationListGui"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    loadFavorites()
    loadKeybinds()

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 330, 0, 400)
    mainFrame.Position = UDim2.new(0.75, -175, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    mainFrame.BorderSizePixel = 0
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 10)
    uiCorner.Parent = mainFrame
    mainFrame.Parent = screenGui

    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 50)
    titleBar.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    titleBar.BorderSizePixel = 0
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 10)
    titleCorner.Parent = titleBar
    titleBar.Parent = mainFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -50, 1, 0)
    titleLabel.Position = UDim2.new(0, 25, 0, 0)
    titleLabel.Text = "Animation List"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 18
    titleLabel.Font = Enum.Font.GothamSemibold
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar

    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -35, 0, 10)
    closeButton.Text = ""
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 18
    closeButton.Font = Enum.Font.GothamSemibold
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
    closeButton.BackgroundTransparency = 0.5
    closeButton.AutoButtonColor = true
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = closeButton
    closeButton.Parent = titleBar

    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "Content"
    contentFrame.Size = UDim2.new(1, -20, 1, -60)
    contentFrame.Position = UDim2.new(0, 10, 0, 55)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame

    local animSearchTextBox = Instance.new("TextBox")
    animSearchTextBox.Name = "AnimSearchTextBox"
    animSearchTextBox.Text = ""
    animSearchTextBox.Size = UDim2.new(1, 0, 0, 30)
    animSearchTextBox.Position = UDim2.new(0, 0, 0, 0)
    animSearchTextBox.PlaceholderText = "Search Animations..."
    animSearchTextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    animSearchTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    animSearchTextBox.ClearTextOnFocus = false
    local animSearchTextBoxCorner = Instance.new("UICorner")
    animSearchTextBoxCorner.CornerRadius = UDim.new(0, 6)
    animSearchTextBoxCorner.Parent = animSearchTextBox
    animSearchTextBox.Parent = contentFrame

    local animScrollFrame = Instance.new("ScrollingFrame")
    animScrollFrame.Name = "AnimScrollFrame"
    animScrollFrame.Size = UDim2.new(1, 0, 1, -40)
    animScrollFrame.Position = UDim2.new(0, 0, 0, 35)
    animScrollFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    animScrollFrame.BorderSizePixel = 0
    animScrollFrame.ScrollBarThickness = 6
    animScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    local scrollFrameCorner = Instance.new("UICorner")
    scrollFrameCorner.CornerRadius = UDim.new(0, 6)
    scrollFrameCorner.Parent = animScrollFrame
    animScrollFrame.Parent = contentFrame

    local animationButtons = {}
    local keybindInputActive = false
    local currentAnimationForKeybind = nil

    local function updateAnimationButtonsVisibility(searchText)
        local yOffset = 5
        local visibleButtonCount = 0

        local sortedAnimationNames = {}
        local favoriteNames = {}
        local nonFavoriteNames = {}

        for animName in pairs(BuiltInAnimationsR15) do
            if favoriteAnimations[animName] then
                table.insert(favoriteNames, animName)
            else
                table.insert(nonFavoriteNames, animName)
            end
        end
        table.sort(favoriteNames)
        table.sort(nonFavoriteNames)
        for _, name in ipairs(favoriteNames) do
            table.insert(sortedAnimationNames, name)
        end
        for _, name in ipairs(nonFavoriteNames) do
            table.insert(sortedAnimationNames, name)
        end


        for _, animName in ipairs(sortedAnimationNames) do
            local animButtonData = animationButtons[animName]
            if not animButtonData then continue end

            if string.find(string.lower(animName), string.lower(searchText)) then
                animButtonData.NameButton.Visible = true
                animButtonData.PlayButton.Visible = true
                animButtonData.FavoriteButton.Visible = true
                animButtonData.StopButton.Visible = true
                animButtonData.KeybindButton.Visible = true
                animButtonData.NameButton.Position = UDim2.new(0, 5, 0, yOffset)
                animButtonData.PlayButton.Position = UDim2.new(0, 5, 0, yOffset + 30)
                animButtonData.FavoriteButton.Position = UDim2.new(1, -125, 0, yOffset)
                animButtonData.StopButton.Position = UDim2.new(1, -85, 0, yOffset)
                animButtonData.KeybindButton.Position = UDim2.new(1, -45, 0, yOffset)
                yOffset = yOffset + 65
                visibleButtonCount = visibleButtonCount + 1

                if favoriteAnimations[animName] then
                    animButtonData.NameButton.BackgroundColor3 = Color3.fromRGB(80, 70, 90)
                else
                    animButtonData.NameButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                end
                updateKeybindButtonText(animButtonData, animName)

            else
                animButtonData.NameButton.Visible = false
                animButtonData.PlayButton.Visible = false
                animButtonData.FavoriteButton.Visible = false
                animButtonData.StopButton.Visible = false
                animButtonData.KeybindButton.Visible = false
            end
        end
        animScrollFrame.CanvasSize = UDim2.new(0, 0, 0, math.max(0, yOffset - 60 + 5))
    end

    for animName, animId in pairs(BuiltInAnimationsR15) do
        local animNameButton = Instance.new("TextButton")
        animNameButton.Name = animName .. "NameButton"
        animNameButton.Size = UDim2.new(1, -80, 0, 30)
        animNameButton.Position = UDim2.new(0, 5, 0, 5)
        animNameButton.Text = animName
        animNameButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        animNameButton.TextSize = 14
        animNameButton.Font = Enum.Font.GothamMedium
        animNameButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        animNameButton.BorderSizePixel = 0
        animNameButton.TextXAlignment = Enum.TextXAlignment.Center
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 4)
        buttonCorner.Parent = animNameButton
        animNameButton.Parent = animScrollFrame

        animNameButton.MouseButton1Click:Connect(function()
            animTextBox.Text = tostring(animId)
        end)

        local playAnimButton = Instance.new("TextButton")
        playAnimButton.Name = animName .. "PlayButton"
        playAnimButton.Size = UDim2.new(1, -10, 0, 30)
        playAnimButton.Position = UDim2.new(0, 5, 0, 35)
        playAnimButton.Text = "Play"
        playAnimButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        playAnimButton.TextSize = 12
        playAnimButton.Font = Enum.Font.GothamMedium
        playAnimButton.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
        playAnimButton.BorderSizePixel = 0
        local playButtonCorner = Instance.new("UICorner")
        playButtonCorner.CornerRadius = UDim.new(0, 4)
        playButtonCorner.Parent = playAnimButton
        playAnimButton.Parent = animScrollFrame

        playAnimButton.MouseButton1Click:Connect(function()
            playFakeAnimation(tostring(animId))
        end)

        local favoriteAnimButton = Instance.new("TextButton")
        favoriteAnimButton.Name = animName .. "FavoriteButton"
        favoriteAnimButton.Size = UDim2.new(0, 40, 0, 30)
        favoriteAnimButton.Position = UDim2.new(1, -125, 0, 5)
        favoriteAnimButton.Text = favoriteAnimations[animName] and "★" or "☆"
        favoriteAnimButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        favoriteAnimButton.TextSize = 20
        favoriteAnimButton.Font = Enum.Font.GothamBold
        favoriteAnimButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        favoriteAnimButton.BorderSizePixel = 0
        local favoriteButtonCorner = Instance.new("UICorner")
        favoriteButtonCorner.CornerRadius = UDim.new(0, 4)
        favoriteButtonCorner.Parent = favoriteAnimButton
        favoriteAnimButton.Parent = animScrollFrame

        favoriteAnimButton.MouseButton1Click:Connect(function()
            if favoriteAnimations[animName] then
                favoriteAnimations[animName] = nil
            else
                favoriteAnimations[animName] = true
            end
            favoriteAnimButton.Text = favoriteAnimations[animName] and "★" or "☆"
            updateAnimationButtonsVisibility(animSearchTextBox.Text)
            saveFavorites()
        end)

        local stopAnimButton = Instance.new("TextButton")
        stopAnimButton.Name = animName .. "StopButton"
        stopAnimButton.Size = UDim2.new(0, 40, 0, 30)
        stopAnimButton.Position = UDim2.new(1, -85, 0, 5)
        stopAnimButton.Text = "🛑"
        stopAnimButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        stopAnimButton.TextSize = 16
        stopAnimButton.Font = Enum.Font.GothamBold
        stopAnimButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        stopAnimButton.BorderSizePixel = 0
        local stopButtonCorner = Instance.new("UICorner")
        stopButtonCorner.CornerRadius = UDim.new(0, 4)
        stopButtonCorner.Parent = stopAnimButton
        stopAnimButton.Parent = animScrollFrame

        stopAnimButton.MouseButton1Click:Connect(function()
            stopFakeAnimation()
        end)

        local keybindAnimButton = Instance.new("TextButton")
        keybindAnimButton.Name = animName .. "KeybindButton"
        keybindAnimButton.Size = UDim2.new(0, 40, 0, 30)
        keybindAnimButton.Position = UDim2.new(1, -45, 0, 5)
        keybindAnimButton.Text = "Set Keybind"
        keybindAnimButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        keybindAnimButton.TextSize = 12
        keybindAnimButton.Font = Enum.Font.GothamMedium
        keybindAnimButton.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
        keybindAnimButton.BorderSizePixel = 0
        local keybindButtonCorner = Instance.new("UICorner")
        keybindButtonCorner.CornerRadius = UDim.new(0, 4)
        keybindButtonCorner.Parent = keybindAnimButton
        keybindAnimButton.Parent = animScrollFrame

        keybindAnimButton.MouseButton1Click:Connect(function()
            if keybindInputActive then return end
            keybindInputActive = true
            currentAnimationForKeybind = animName
            keybindAnimButton.Text = "Press"

            local function inputBeganHandler(input, gameProcessedEvent)
                if not keybindInputActive or currentAnimationForKeybind ~= animName then return end
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    animationKeybinds[animName] = input.KeyCode
                    saveKeybinds()
                    updateKeybindButtonText(animationButtons[animName], animName)
                    keybindInputActive = false
                    currentAnimationForKeybind = nil
                    UserInputService.InputBegan:Disconnect(inputBeganHandler)
                elseif input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    updateKeybindButtonText(animationButtons[animName], animName)
                    keybindInputActive = false
                    currentAnimationForKeybind = nil
                    UserInputService.InputBegan:Disconnect(inputBeganHandler)
                end
            end

            UserInputService.InputBegan:Connect(inputBeganHandler)
        end)


        animationButtons[animName] = {
            NameButton = animNameButton,
            PlayButton = playAnimButton,
            FavoriteButton = favoriteAnimButton,
            StopButton = stopAnimButton,
            KeybindButton = keybindAnimButton
        }
    end

    updateAnimationButtonsVisibility("")

    animSearchTextBox:GetPropertyChangedSignal("Text"):Connect(function()
        updateAnimationButtonsVisibility(animSearchTextBox.Text)
    end)

    local dragging = false
    local dragInput, dragStart, startPos
    local function updateInput(input)
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input == dragInput) then
            updateInput(input)
        end
    end)

    return screenGui
end

local animationListGui = nil

local function createDraggableGui(getGhostEnabled, toggleGhost, getSizeValue, setSizeValue, getWidthValue, setWidthValue)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "EnhancedGhostGui"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 350, 0, 450)
    mainFrame.Position = UDim2.new(0.5, -175, 0.5, -225)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    mainFrame.BorderSizePixel = 0
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 10)
    uiCorner.Parent = mainFrame
    mainFrame.Parent = screenGui

    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    titleBar.BorderSizePixel = 0
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 10)
    titleCorner.Parent = titleBar
    titleBar.Parent = mainFrame

    local titleBarBottom = Instance.new("Frame")
    titleBarBottom.Name = "BottomEdge"
    titleBarBottom.Size = UDim2.new(1, 0, 0, 10)
    titleBarBottom.Position = UDim2.new(0, 0, 1, -10)
    titleBarBottom.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    titleBarBottom.BorderSizePixel = 0
    titleBarBottom.ZIndex = 0
    titleBarBottom.Parent = titleBar

    local logo = Instance.new("ImageLabel")
    logo.Name = "Logo"
    logo.Size = UDim2.new(0, 24, 0, 24)
    logo.Position = UDim2.new(0, 13, 0, 8)
    logo.BackgroundTransparency = 1
    logo.Image = "rbxassetid://6022668885"
    logo.Parent = titleBar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -100, 1, 0)
    titleLabel.Position = UDim2.new(0, 50, 0, 0)
    titleLabel.Text = "Reanimation"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 18
    titleLabel.Font = Enum.Font.GothamSemibold
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar

    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Name = "MinimizeButton"
    minimizeButton.Size = UDim2.new(0, 30, 0, 30)
    minimizeButton.Position = UDim2.new(1, -65, 0, 5)
    minimizeButton.Text = "-"
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.TextSize = 24
    minimizeButton.Font = Enum.Font.GothamSemibold
    minimizeButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    minimizeButton.BackgroundTransparency = 0.5
    minimizeButton.AutoButtonColor = true
    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 8)
    minimizeCorner.Parent = minimizeButton
    minimizeButton.Parent = titleBar

    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -35, 0, 5)
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 18
    closeButton.Font = Enum.Font.GothamSemibold
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
    closeButton.BackgroundTransparency = 0.5
    closeButton.AutoButtonColor = true
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = closeButton
    closeButton.Parent = titleBar

    -- Content Frame
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "Content"
    contentFrame.Size = UDim2.new(1, -20, 1, -50)
    contentFrame.Position = UDim2.new(0, 10, 0, 45)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame

    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Size = UDim2.new(1, 0, 0, 40)
    toggleButton.Position = UDim2.new(0, 0, 0, 0)
    toggleButton.Text = "Enable Reanimation"
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.TextSize = 16
    toggleButton.Font = Enum.Font.GothamSemibold
    toggleButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
    toggleButton.BorderSizePixel = 0
    toggleButton.AutoButtonColor = true
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 8)
    toggleCorner.Parent = toggleButton
    toggleButton.Parent = contentFrame

    local sizeSection = Instance.new("Frame")
    sizeSection.Name = "SizeSection"
    sizeSection.Size = UDim2.new(1, 0, 0, 50)
    sizeSection.Position = UDim2.new(0, 0, 0, 45)
    sizeSection.BackgroundTransparency = 1
    sizeSection.Parent = contentFrame

    local sizeLabel = Instance.new("TextLabel")
    sizeLabel.Name = "SizeLabel"
    sizeLabel.Size = UDim2.new(1, 0, 0, 20)
    sizeLabel.Text = "Clone Size: 100%"
    sizeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    sizeLabel.TextSize = 14
    sizeLabel.Font = Enum.Font.GothamMedium
    sizeLabel.BackgroundTransparency = 1
    sizeLabel.TextXAlignment = Enum.TextXAlignment.Left
    sizeLabel.Parent = sizeSection

    local sizeSliderBG = Instance.new("Frame")
    sizeSliderBG.Name = "SliderBG"
    sizeSliderBG.Size = UDim2.new(1, 0, 0, 12)
    sizeSliderBG.Position = UDim2.new(0, 0, 0, 25)
    sizeSliderBG.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    sizeSliderBG.BorderSizePixel = 0
    local sliderBGCorner = Instance.new("UICorner")
    sliderBGCorner.CornerRadius = UDim.new(0, 4)
    sliderBGCorner.Parent = sizeSliderBG
    sizeSliderBG.Parent = sizeSection

    local sizeSliderFill = Instance.new("Frame")
    sizeSliderFill.Name = "SliderFill"
    sizeSliderFill.Size = UDim2.new(0.5, 0, 1, 0)
    sizeSliderFill.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    sizeSliderFill.BorderSizePixel = 0
    local sliderFillCorner = Instance.new("UICorner")
    sliderFillCorner.CornerRadius = UDim.new(0, 4)
    sliderFillCorner.Parent = sliderFill
    sizeSliderFill.Parent = sizeSliderBG

    local function updateSizeSlider(value)
        local fillValue = 0
        if value <= 0.5 then
            fillValue = 0
        elseif value >= 20 then
            fillValue = 1
        else
            fillValue = (value - 0.5) / 19.5
        end
        sizeSliderFill.Size = UDim2.new(fillValue, 0, 1, 0)
        sizeLabel.Text = "Clone Size: " .. math.floor(value * 100) .. "%"
        setSizeValue(value)
    end

    updateSizeSlider(getSizeValue())

    local isDraggingSize = false
    local function updateSizeFromPosition(input)
        local sliderPosition = (input.Position.X - sizeSliderBG.AbsolutePosition.X) / sizeSliderBG.AbsoluteSize.X
        sliderPosition = math.clamp(sliderPosition, 0, 1)
        local newValue = 0.5 + sliderPosition * 19.5
        updateSizeSlider(newValue)
    end

    sizeSliderBG.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDraggingSize = true
            updateSizeFromPosition(input)
        end
    end)
    sizeSliderBG.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDraggingSize = false
        end
    end)
    sizeSliderBG.InputChanged:Connect(function(input)
        if isDraggingSize and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSizeFromPosition(input)
        end
    end)

    -- Width Slider Section (compact layout)
    local widthSection = Instance.new("Frame")
    widthSection.Name = "WidthSection"
    widthSection.Size = UDim2.new(1, 0, 0, 50)
    widthSection.Position = UDim2.new(0, 0, 0, 95)
    widthSection.BackgroundTransparency = 1
    widthSection.Parent = contentFrame

    local widthLabel = Instance.new("TextLabel")
    widthLabel.Name = "WidthLabel"
    widthLabel.Size = UDim2.new(1, 0, 0, 20)
    widthLabel.Text = "Clone Width: 100%"
    widthLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    widthLabel.TextSize = 14
    widthLabel.Font = Enum.Font.GothamMedium
    widthLabel.BackgroundTransparency = 1
    widthLabel.TextXAlignment = Enum.TextXAlignment.Left
    widthLabel.Parent = widthSection

    local widthSliderBG = Instance.new("Frame")
    widthSliderBG.Name = "WidthSliderBG"
    widthSliderBG.Size = UDim2.new(1, 0, 0, 12)
    widthSliderBG.Position = UDim2.new(0, 0, 0, 25)
    widthSliderBG.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    widthSliderBG.BorderSizePixel = 0
    local widthSliderBGCorner = Instance.new("UICorner")
    widthSliderBGCorner.CornerRadius = UDim.new(0, 4)
    widthSliderBGCorner.Parent = widthSliderBG
    widthSliderBG.Parent = widthSection

    local widthSliderFill = Instance.new("Frame")
    widthSliderFill.Name = "SliderFill"
    widthSliderFill.Size = UDim2.new(0.5, 0, 1, 0)
    widthSliderFill.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    widthSliderFill.BorderSizePixel = 0
    local widthSliderFillCorner = Instance.new("UICorner")
    widthSliderFillCorner.CornerRadius = UDim.new(0, 4)
    widthSliderFillCorner.Parent = widthSliderFill
    widthSliderFill.Parent = widthSliderBG

    local function updateWidthSlider(value)
        local fillValue = 0
        if value <= 0.5 then
            fillValue = 0
        elseif value >= 20 then
            fillValue = 1
        else
            fillValue = (value - 0.5) / 19.5
        end
        widthSliderFill.Size = UDim2.new(fillValue, 0, 1, 0)
        widthLabel.Text = "Clone Width: " .. math.floor(value * 100) .. "%"
        setWidthValue(value)
    end

    updateWidthSlider(getWidthValue())

    local isDraggingWidth = false
    local function updateWidthFromPosition(input)
        local sliderPosition = (input.Position.X - widthSliderBG.AbsolutePosition.X) / widthSliderBG.AbsoluteSize.X
        sliderPosition = math.clamp(sliderPosition, 0, 1)
        local newValue = 0.5 + sliderPosition * 19.5
        updateWidthSlider(newValue)
    end

    widthSliderBG.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDraggingWidth = true
            updateWidthFromPosition(input)
        end
    end)
    widthSliderBG.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDraggingWidth = false
        end
    end)
    widthSliderBG.InputChanged:Connect(function(input)
        if isDraggingWidth and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateWidthFromPosition(input)
        end
    end)

    local speedSection = Instance.new("Frame")
    speedSection.Name = "SpeedSection"
    speedSection.Size = UDim2.new(1, 0, 0, 50)
    speedSection.Position = UDim2.new(0, 0, 0, 145)
    speedSection.BackgroundTransparency = 1
    speedSection.Parent = contentFrame

    local speedLabel = Instance.new("TextLabel")
    speedLabel.Name = "SpeedLabel"
    speedLabel.Size = UDim2.new(1, 0, 0, 20)
    speedLabel.Text = "Animation Speed: 100%"
    speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    speedLabel.TextSize = 14
    speedLabel.Font = Enum.Font.GothamMedium
    speedLabel.BackgroundTransparency = 1
    speedLabel.TextXAlignment = Enum.TextXAlignment.Left
    speedLabel.Parent = speedSection

    local speedSliderBG = Instance.new("Frame")
    speedSliderBG.Name = "SpeedSliderBG"
    speedSliderBG.Size = UDim2.new(1, 0, 0, 12)
    speedSliderBG.Position = UDim2.new(0, 0, 0, 25)
    speedSliderBG.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    speedSliderBG.BorderSizePixel = 0
    local speedSliderBGCorner = Instance.new("UICorner")
    speedSliderBGCorner.CornerRadius = UDim.new(0, 4)
    speedSliderBGCorner.Parent = speedSliderBG
    speedSliderBG.Parent = speedSection

    local speedSliderFill = Instance.new("Frame")
    speedSliderFill.Name = "SpeedSliderFill"
    speedSliderFill.Size = UDim2.new(1, 0, 1, 0)
    speedSliderFill.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    speedSliderFill.BorderSizePixel = 0
    local speedSliderFillCorner = Instance.new("UICorner")
    speedSliderFillCorner.CornerRadius = UDim.new(0, 4)
    speedSliderFillCorner.Parent = speedSliderFill
    speedSliderFill.Parent = speedSliderBG

    local function updateSpeedSlider(value)
        local fillValue = 0
        if value <= 0 then
            fillValue = 0
        elseif value >= 3.6 then
            fillValue = 1
        else
            fillValue = (value) / (3.6)
        end
        speedSliderFill.Size = UDim2.new(fillValue, 0, 1, 0)
        speedLabel.Text = "Animation Speed: " .. math.floor(value * 100) .. "%"
        fakeAnimSpeed = value
    end

    updateSpeedSlider(1.7)

    local isDraggingSpeed = false
    local function updateSpeedFromPosition(input)
        local sliderPosition = (input.Position.X - speedSliderBG.AbsolutePosition.X) / speedSliderBG.AbsoluteSize.X
        sliderPosition = math.clamp(sliderPosition, 0, 1)
        local newValue = sliderPosition * 3.6
        updateSpeedSlider(newValue)
    end

    speedSliderBG.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDraggingSpeed = true
            updateSpeedFromPosition(input)
        end
    end)
    speedSliderBG.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDraggingSpeed = false
        end
    end)
    speedSliderBG.InputChanged:Connect(function(input)
        if isDraggingSpeed and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSpeedFromPosition(input)
        end
    end)


    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    local originalGuiHeight = mainFrame.Size.Y.Offset
    local minimizedGuiHeight = titleBar.Size.Y.Offset + 10
    local minimized = false

    minimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            contentFrame.Visible = false
            mainFrame.Size = UDim2.new(0, mainFrame.Size.X.Offset, 0, minimizedGuiHeight)
        else
            contentFrame.Visible = true
            mainFrame.Size = UDim2.new(0, mainFrame.Size.X.Offset, 0, originalGuiHeight)
        end
    end)

    toggleButton.MouseButton1Click:Connect(function()
        local newState = not getGhostEnabled()
        toggleGhost(newState)
        if newState then
            toggleButton.Text = "Disable Reanimation"
            toggleButton.BackgroundColor3 = Color3.fromRGB(211, 47, 47)
            updateSizeSlider(getSizeValue())
            updateWidthSlider(getWidthValue())
        else
            toggleButton.Text = "Enable Reanimation"
            toggleButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
        end
    end)

    local dragging = false
    local dragInput, dragStart, startPos
    local function updateInput(input)
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input == dragInput) then
            updateInput(input)
        end
    end)

    local fakeAnimSection = Instance.new("Frame")
    fakeAnimSection.Name = "FakeAnimSection"
    fakeAnimSection.Size = UDim2.new(1, 0, 0, 50)
    fakeAnimSection.Position = UDim2.new(0, 0, 0, 195)
    fakeAnimSection.BackgroundTransparency = 1
    fakeAnimSection.Parent = contentFrame

    local fakeAnimTextBox = Instance.new("TextBox")
    fakeAnimTextBox.Name = "FakeAnimTextBox"
    fakeAnimTextBox.Text = ""
    fakeAnimTextBox.Size = UDim2.new(0.8, 0, 0.8, 0)
    fakeAnimTextBox.Position = UDim2.new(0.1, 0, 0, 0)
    fakeAnimTextBox.PlaceholderText = "Animation ID"
    fakeAnimTextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    fakeAnimTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    local fakeAnimTextBoxCorner = Instance.new("UICorner")
    fakeAnimTextBoxCorner.CornerRadius = UDim.new(0, 6)
    fakeAnimTextBoxCorner.Parent = fakeAnimTextBox
    fakeAnimTextBox.Parent = fakeAnimSection

    local fakeAnimButton = Instance.new("TextButton")
    fakeAnimButton.Name = "FakeAnimButton"
    fakeAnimButton.Size = UDim2.new(0.8, 0, 0.8, 0)
    fakeAnimButton.Position = UDim2.new(0.1, 0, 1, 0)
    fakeAnimButton.Text = "Play Animation"
    fakeAnimButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    fakeAnimButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    local fakeAnimButtonCorner = Instance.new("UICorner")
    fakeAnimButtonCorner.CornerRadius = UDim.new(0, 8)
    fakeAnimButtonCorner.Parent = fakeAnimButton
    fakeAnimButton.Parent = fakeAnimSection

    local stopFakeAnimButton = Instance.new("TextButton")
    stopFakeAnimButton.Name = "StopFakeAnimButton"
    stopFakeAnimButton.Size = UDim2.new(0.8, 0, 0.8, 0)
    stopFakeAnimButton.Position = UDim2.new(0.1, 0, 2, 0)
    stopFakeAnimButton.Text = "Stop Animation"
    stopFakeAnimButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    stopFakeAnimButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    local stopFakeAnimButtonCorner = Instance.new("UICorner")
    stopFakeAnimButtonCorner.CornerRadius = UDim.new(0, 8)
    stopFakeAnimButtonCorner.Parent = stopFakeAnimButton
    stopFakeAnimButton.Parent = fakeAnimSection

    fakeAnimButton.MouseButton1Click:Connect(function()
        if ghostClone then
            local animId = fakeAnimTextBox.Text
            playFakeAnimation(animId)
        else
            warn("No fake character available!")
        end
    end)

    stopFakeAnimButton.MouseButton1Click:Connect(function()
        stopFakeAnimation()
    end)

    local animListSection = Instance.new("Frame")
    animListSection.Name = "AnimListSection"
    animListSection.Size = UDim2.new(1, 0, 0, 40)
    animListSection.Position = UDim2.new(0, 0, 1, -40)
    animListSection.BackgroundTransparency = 1
    animListSection.Parent = contentFrame

    local animListButton = Instance.new("TextButton")
    animListButton.Name = "AnimListButton"
    animListButton.Size = UDim2.new(1, 0, 1, 0)
    animListButton.Position = UDim2.new(0, 0, 0, 0)
    animListButton.Text = "Open Animation List"
    animListButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    animListButton.TextSize = 16
    animListButton.Font = Enum.Font.GothamSemibold
    animListButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    animListButton.BorderSizePixel = 0
    animListButton.AutoButtonColor = true
    local animListCorner = Instance.new("UICorner")
    animListCorner.CornerRadius = UDim.new(0, 8)
    animListCorner.Parent = animListButton
    animListButton.Parent = animListSection

    animListButton.MouseButton1Click:Connect(function()
        if animationListGui then
            animationListGui:Destroy()
            animationListGui = nil
            animListButton.Text = "Open Animation List"
        else
            animationListGui = createAnimationListGui(fakeAnimTextBox)
            animListButton.Text = "Close Animation List"
        end
    end)

    return screenGui
end

local gui = createDraggableGui(
    function() return ghostEnabled end,
    setGhostEnabled,
    function() return cloneSize end,
    function(size)
        cloneSize = size
        if ghostEnabled and ghostClone then
            updateCloneScale()
        end
    end,
    function() return cloneWidth end,
    function(width)
        cloneWidth = width
        if ghostEnabled and ghostClone then
            updateCloneScale()
        end
    end)
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end
    if input.UserInputType == Enum.UserInputType.Keyboard then
        for animName, keyCode in pairs(animationKeybinds) do
            if input.KeyCode == keyCode then
                playFakeAnimation(BuiltInAnimationsR15[animName])
                return 
            end
        end
    end
end)
