{ config, pkgs, lib, nur, ... }:

let
  unstable = import <nixos-unstable> {
    config.allowUnfree = true;

    config.packageOverrides = pkgs: {
      nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
    };
  };
in
{
  programs.firefox = {
    enable = true;

    # package = pkgs.firefox-wayland;

    profiles."williams" = {
      id = 0;
      name = "William Sørensen";

      # extensions =
      #   with nur.repos.rycee.firefox-addons; [
      #     bitwarden
      #     darkreader
      #     vimium
      #     ublock-origin
      #   ];

      # bookmarks =
      #   [
      # {
      #   name = "old";
      #   bookmarks = [
      #     {
      #       name = "Music";

      #       bookmarks = [
      #         { url = "file:///C:/ProgramData/Ableton/Live%209%20Lite/Docs/User%20Manual%20English.pdf"; name = "Ableton User Manual English pdf"; }
      #         { url = "https://www.ableton.com/en/shop/live/"; name = "Ableton"; }
      #         { url = "https://splice.com/blog/creating-multiple-revenue-streams/?utm_source=mailchimp&utm_medium=email&utm_campaign=newsletter&utm_term=creating-multiple-revenue-streams"; name = "DIstreb music"; }
      #         { url = "https://www.distrokid.com/vip/seven/722518"; name = "Distro kid - musik uplode"; }
      #         { url = "http://tailorednoise-downloads.com/DadaLifePurchase.php"; name = "Esmile Fsusage- Purchase Software"; }
      #         { url = "https://app.landr.com/library"; name = "LANDR"; }
      #         { url = "https://www.native-instruments.com/en/products/"; name = "NI Products"; }
      #         { url = "https://nsynthsuper.withgoogle.com/"; name = "NSynth Super"; }
      #         { url = "https://refx.com/nexus/"; name = "Nexus"; }
      #         { url = "https://output.com/blog/output-favorites-freebies"; name = "OUTPUT FAVORITES  Freebies"; }
      #         { url = "https://www.renderforest.com/music-visualisations"; name = "Online Audio Visualization"; }
      #         { url = "https://output.com/account?password-reset=true"; name = "Output"; }
      #         { url = "https://www.native-instruments.com/en/reaktor-community/reaktor-user-library/all/all/all/all/all/latest/1/all/"; name = "Reaktor User Library"; }
      #         { url = "https://www.expressivee.com/eesounds/all-sounds"; name = "Some presets"; }
      #         { url = "https://www.propellerheads.se/"; name = "Synths"; }
      #         { url = "http://www.fromtexttospeech.com/"; name = "Text to speach"; }
      #         { url = "https://www.xferrecords.com/products/serum"; name = "serum lfo tool"; }
      #         { url = "https://www.kickstart-plugin.com/"; name = "sidecahin"; }
      #         { url = "https://www.reveal-sound.com/"; name = "spire"; }
      #         { url = "https://www.waves.com/"; name = "waves vst&#39;s"; }
      #         { url = "https://www.reddit.com/r/edmproduction/comments/77hjvh/virtual_riot_add_phat_rack_for_ableton_live_used/"; name = "PHAT Rack"; }
      #         { url = "https://metapop.com/omnisonic"; name = "OmniSonic | metapop"; }
      #         { url = "https://www.soundgym.co/dashboard/gym"; name = "Sound traning"; }
      #         { url = "https://www.dropbox.com/s/lu1t2jhsvr8su0g/dONK.fxp?dl=0"; name = "dONK.fxp"; }
      #         { url = "https://drive.google.com/file/d/0BxkFS27Ej4HgWXJqR0pwWHg5M2s/view"; name = "Evolution Of Sound - Sub 37 Wavetables.zip - Google Disk"; }
      #         { url = "https://www.rocketpoweredsound.com/free"; name = "Free Downloads | Rocket Powered Sound"; }
      #         { url = "https://www.evosounds.com/"; name = "Evolution Of Sound"; }
      #         { url = "https://www.vocaloid.com/en/"; name = "VOCALOID – the modern singing synthesizer –"; }
      #         { url = "https://www.arturia.com/products/analog-classics/pigments/overview#en"; name = "Arturia"; }
      #         { url = "https://u-he.com/products/"; name = "Synts from U-he"; }
      #         { url = "https://www.rocketpoweredsound.com/"; name = "Rocket Powered Sound "; }
      #         { url = "https://www.rocketpoweredsound.com/free-access?utm_content=8214507&utm_medium=Email&utm_name=Id&utm_source=Actionetics&utm_term=Email"; name = "Free Downloads | Rocket Powered Sound"; }
      #         { url = "https://www.spitfireaudio.com/labs/"; name = "LABS - Free Virtual Instruments"; }
      #         { url = "https://api.moogmusic.com/sites/default/files/2018-08/Grandmother_Manual.pdf"; name = "Grandmother_Manual.pdf"; }
      #         { url = "https://oversampled.us/collections/free-packs"; name = "Free Packs – Oversampled"; }
      #         { url = "https://reverb.com/p/arturia-microbrute?gspk=QW5kcmV3SHVhbmc%3D&gsxid=mx6h4FC1ffQL"; name = "Cheap hardwhear synth"; }
      #         { url = "https://soundcloud.com/revealed-recordings/hardwell-acapella-pack-1m-likes-giveaway"; name = "Hardwell Acapella Pack (Free Download) by Revealed Recordings"; }
      #         { url = "https://cymatics.fm/pages/free-download-vault"; name = "Free Samples &amp; Presets – Cymatics.fm"; }
      #         { url = "https://cymatics.fm/pages/secret-free-download"; name = "Free Download Vault – Cymatics.fm"; }
      #         { url = "https://reveal-sound.com/plug-ins/spire"; name = "spier"; }
      #         { url = "https://www.evosounds.com/bigroomsamplepacks"; name = "The Ultimate Big Room Sample Pack"; }
      #         { url = "https://output.com/products/signal"; name = "SIGNAL   Pulse Engine   vst"; }
      #       ];
      #     }
      #     {
      #       name = "Blender";

      #       bookmarks = [
      #         { url = "https://remingtongraphics.net/"; name = "Remington Graphics"; }
      #         { url = "https://www.creativeshrimp.com/60-links-for-artists.html"; name = "Blender links"; }
      #         { url = "https://i.imgur.com/WLuQkYc.png"; name = "Rust mitereal"; }
      #         { url = "https://www.textures.com/"; name = "Texturs"; }
      #         { url = "https://www.poliigon.com/"; name = "Texsturs"; }
      #         { url = "https://www.cgcookie.com/"; name = "CG tutarials"; }
      #         { url = "file:///C:/Users/William/Documents/Blender%20shortcust.pdf"; name = "Blender shortcust pdf"; }
      #         { url = "https://gumroad.com/l/hopscutter"; name = "Hard Ops / Boxcutter Ultimate Bundle (2.8)"; }
      #         { url = "https://gumroad.com/masterxeon1001"; name = "masterXeon1001 on Gumroad"; }
      #         { url = "https://www.blender.org/"; name = "blender.org - Home of the Blender project - Free and Open 3D Creation Software"; }
      #         { url = "https://gumroad.com/l/TLMXset01"; name = "TL-MX Decals for Blender - Set 01"; }
      #         { url = "https://gumroad.com/l/kitopsprolite/"; name = "KIT OPS PRO Lite kitbashing addon for Blender"; }
      #         { url = "https://blendermarket.com/creators/mark-kingsnorth"; name = "Some addons"; }
      #         { url = "https://www.lfd.uci.edu/~gohlke/pythonlibs/#numpy"; name = "Python Extensions"; }
      #         { url = "https://www.world-machine.com/"; name = "World Machine : The Premier 3D Terrain Generator"; }
      #         { url = "https://www.cgtrader.com/free-3d-models?keywords=salad&suggested=1"; name = "Free Salad 3D Models | CGTrader"; }
      #         { url = "https://www.cgtrader.com/welcome"; name = "Welcome | CGTrader"; }
      #         { url = "https://openimagedenoise.github.io/"; name = "Intel Open Image Denoise"; }
      #         { url = "https://blendermarket.com/products/MESHmachine"; name = "MESHmachine - Blender MarketMESHmachine - Blender Market"; }
      #         { url = "https://www.cgtrader.com/free-3d-models/shampoo"; name = "Free Shampoo 3D Models | CGTrader"; }
      #         { url = "https://www.cgtrader.com/"; name = "CGTrader"; }
      #         { url = "https://hdrihaven.com/"; name = "HDRI Haven"; }
      #         { url = "https://windmillart.net/?p=jsplacement"; name = "Windmill "; }
      #         { url = "https://studio.vroid.com/index.html"; name = "VRoid Studio"; }
      #         { url = "https://blendermarket.com/posts/flip-fluids-10-tips-to-improve-your-blender-workflow"; name = "10 Tips to Improve Your FLIP Fluids Workflow in Blender - Blender Market"; }
      #         { url = "https://gumroad.com/cgthoughts?recommended_by=search#"; name = "Fluent"; }
      #         { url = "https://www.artstation.com/ivangraphics"; name = "Cool consepts"; }
      #         { url = "https://www.blendermarket.com/pickup/7jfp8q"; name = "Blender hard surf"; }
      #         { url = "https://builder.blender.org/download/"; name = "Blender Builder"; }
      #         { url = "https://snorpey.github.io/jpg-glitch/"; name = "Image Glitch Tool"; }
      #         { url = "https://www.pluralsight.com/"; name = "Pluralsight"; }
      #         { url = "https://www.dropbox.com/s/3j61d896my0v8e5/Blender%20Cheatsheet%20v1.pdf?dl=0"; name = "Blender Cheatsheet v1.pdf"; }
      #         { url = "https://www.youtube.com/channel/UCzCcofKd2wi8UvdutOkxp2w"; name = "Simon Thommes - textures"; }
      #         { url = "https://quadspinner.com/"; name = "terainGen"; }
      #         { url = "https://cc0textures.com/"; name = "more textures"; }
      #         { url = "https://gumroad.com/rart#iPTrw"; name = "hudini castle"; }
      #       ];
      #     }
      #     {
      #       name = "Psyke";
      #       bookmarks = [
      #         { url = "https://www.erowid.org/"; name = "Erowid"; }
      #         { url = "https://www.findlaw.com/legalblogs/law-and-life/drug-schedules-explained/"; name = "Drug Schedules Explained - FindLaw"; }
      #         { url = "https://www.choosingtherapy.com/manipulation-tactics/"; name = "index"; }
      #       ];
      #     }
      #     {
      #       name = "Art";
      #       bookmarks = [
      #         { url = "https://www.mclelun.com/2017/06/painting-makoto-shinkai-style-anime.html"; name = "Painting Makoto Shinkai Style Anime Background From Photo"; }
      #         { url = "https://lusion.co/"; name = "Lusion"; }
      #         { url = "https://bloodmachines.com/"; name = "bloodmachines"; }
      #         { url = "https://ia.net/downloads#templates"; name = "Free trials of iA Writer, free templates and the Mono, Duo and Quattro fonts"; }
      #       ];
      #     }

      #     { url = "https://en.wikipedia.org/wiki/All_the_Bright_Places"; name = "the times i need someone"; }
      #     { url = "https://coolcomponents.co.uk/"; name = "Arduino | Raspberry Pi | Microbit"; }
      #     { url = "https://www.nintendo.com/games/detail/astral-chain-switch/"; name = "ASTRAL CHAIN for Nintendo "; }
      #     { url = "1594757928"; name = "saved websites<"; }
      #     { url = "https://www.amazon.co.uk/YuGiOh-Card-Condition-SHIPPING-yugioh/dp/B00TXMYKSO/ref=sr_1_fkmr1_4?s=kids&ie=UTF8&qid=1502099313&sr=1-4-fkmr1&keywords=yugioh+all+Jinzo+cards"; name = "200 YuGiOh Card LOT! Mint Condition! Includes all Sets   FAST SHIPPING   by yugioh  Amazon co uk  Toys &amp; Games"; }
      #     { url = "http://nucific.com/3harmfulfoods/index2.php?utm_expid=101999475-8.3FJ_5-g-RmauyZ2uVf-DBQ.1&gclid=CjwKEAjwtpDMBRC4xebfxpzu8mUSJAA4c-TuY2wLmHVZ5tkhu88QAa4za6RlZSfSCIEOiRutr9Jv-BoC0Kzw_wcB"; name = "3 Harmful Foods"; }
      #     { url = "https://discordapp.com/developers/docs/intro"; name = "Discord - Developer Documentation"; }
      #     { url = "https://www.typingclub.com/typing-qwerty-en.html"; name = "Learn Touch Typing Free - TypingClub"; }
      #     { url = "https://www.16personalities.com/free-personality-test"; name = "P test"; }
      #     { url = "https://spacedock.info/kerbal-space-program"; name = "SpaceDock"; }
      #     { url = "https://starmadedock.net/"; name = "StarMade Dock"; }
      #     { url = "https://textfac.es/"; name = "Text faces   Lenny face ( ͡° ͜ʖ ͡°), shrug face ¯ _(ツ)_ ¯, look of disapproval ಠ_ಠ and more"; }
      #     { url = "http://www.aminoapps.com/page/ygo/8415945/top-10-favorite-synchro-monsters"; name = "Top 110 Favorite Synchro Monsters   YGO Amino"; }
      #     { url = "https://fronter.com/tromsgs/main.phtml"; name = "Troms GS"; }
      #     { url = "https://www.unrealengine.com/en-US/blog"; name = "Unreal Engine"; }
      #     { url = "https://www.sparebank1.no/nb/nord-norge/privat/innlogging.html"; name = "bank"; }
      #     { url = "https://www.youtube.com/watch?v=W7xQ9kLFYFs"; name = "discord server info"; }
      #     { url = "https://blogs.technet.microsoft.com/heyscriptingguy/2015/06/11/table-of-basic-powershell-commands/"; name = "WPShell commands"; }
      #     { url = "https://standard.tv/collections/in-a-nutshell/"; name = "Kurzgesagt - In a Nutshell merch"; }
      #     { url = "https://www.skillshare.com/signup?redirectTo=https%3A%2F%2Fwww.skillshare.com%2Fmembership%2Fcheckout%3Fcoupon%3DYTSAMANDNIKO%26utm_source%3DYoutube%26utm_medium%3Dpaid-SamandNiko%26utm_campaign%3D2017-11-SamandNiko-2%26utm_content%3Dcta-link"; name = "Sign up - Skillshare"; }
      #     { url = "https://www.amazon.co.uk/Games-Play-Your-Head-Yourself/dp/0998379417/ref=sr_1_1?ie=UTF8&qid=1551600649&sr=8-1&keywords=Top+10+Games+You+Can+Play+In+Your+Head%2C+By+Yourself%3A+Second+Edition"; name = "Top 10 Games You Can Play In Your Head, By Yourself: Second Edition: Amazon.co.uk: J. Theophrastus Bartholomew, Sam Gorski, D. F. Lovett: 9780998379418: Books"; }
      #     { url = "https://autotorio.com/blueprint"; name = "Autotorio"; }
      #     { url = "https://www.easeus.com/partition-master/format-usb-flash-drive-using-cmd.html"; name = "Guide: How to Format USB Flash Drive Using Cmd - EaseUS"; }
      #     { url = "https://bgr.com/2019/10/11/pc-monitor-amazon-frameless-sale/"; name = "monitor"; }
      #     { url = "https://medium.com/mit-technology-review/how-to-turn-the-complex-mathematics-of-vector-calculus-into-simple-pictures-f3ea8d8b3830"; name = "How to Turn the Complex Mathematics of Vector Calculus Into Simple Pictures"; }
      #   ];
      # }
      # {
      #   name = "Code";
      #   bookmarks = [
      #     { url = "https://openexchangerates.github.io/money.js/"; name = "money.js "; }
      #     { url = "https://nitratine.net/blog/post/encryption-and-decryption-in-python/"; name = "Encryption and Decryption in Python - Nitratine"; }
      #     { url = "https://discordpy.readthedocs.io/en/latest/"; name = "Welcome to discord.py — discord.py 1.2.0a documentation"; }
      #     { url = "https://discordpy.readthedocs.io/en/latest/index.html"; name = "discord.py"; }
      #     { url = "https://discordapp.com/developers/applications/"; name = "Discord Developer Portal — My Applications"; }
      #     { url = "https://gumroad.com/discover?query=fluent#HtPBE"; name = "Gumroad Discover"; }
      #     { url = "https://processing.org/download/"; name = "Codebullet software"; }
      #     { url = "https://www.futurelearn.com/courses/object-oriented-principles/8/steps/551472"; name = "how to make a module"; }
      #     { url = "https://www.futurelearn.com/courses/object-oriented-principles/8/steps/551473"; name = "making good docs"; }
      #     { url = "https://docs.python.org/3/reference/datamodel.html#special-method-names"; name = "magic / dunder for classes"; }
      #     { url = "https://medium.com/@madasamy/introduction-to-recommendation-systems-and-how-to-design-recommendation-system-that-resembling-the-9ac167e30e95"; name = "Introduction to recommendation systems "; }
      #     { url = "https://en.wikipedia.org/wiki/PageRank#Simplified_algorithm"; name = "google search engin"; }
      #     { url = "https://beckernick.github.io/matrix-factorization-recommender/"; name = "Matrix Factorization for Movie Recommendations "; }
      #     { url = "https://docs.python-guide.org/writing/gotchas/"; name = "Common Gotchas — The Hitchhiker&#39;s Guide to Python"; }
      #     { url = "https://book.pythontips.com/en/latest/__slots__magic.html"; name = "open python book"; }
      #     { url = "https://medium.com/better-programming/lambda-map-and-filter-in-python-4935f248593"; name = "Lambda, Map, and Filter in Python"; }
      #     { url = "https://towardsdatascience.com/the-next-level-of-data-visualization-in-python-dd6e99039d5e"; name = "matplotlib alternitive"; }
      #     { url = "https://learn-anything.xyz/"; name = "Learn Anything"; }
      #     { url = "https://docs.python.org/3/reference/import.html#__file__"; name = "The import system python"; }
      #     { url = "https://www.spoj.com/"; name = "Prog puzzels"; }
      #     { url = "https://uhs.es/Python%20standard%20library%20by%20example.pdf"; name = "1300 pages of python docs"; }
      #     { url = "https://towardsdatascience.com/introduction-to-recommender-systems-6c66cf15ada"; name = "Introduction to recommender systems - Towards Data Science"; }
      #     { url = "https://docs.python.org/3/library/asyncio-task.html"; name = "Coroutines and Tasks — Python 3.8.0 documentation"; }
      #     { url = "https://css-tricks.com/"; name = "CSS-Tricks"; }
      #     { url = "https://github.com/nodejs/node"; name = "nodejs/node: Node.js JavaScript runtime"; }
      #     { url = "https://medium.com/better-programming/python-memory-and-multiprocessing-ed517b8db8fd"; name = "Python Memory and Multiprocessing"; }
      #     { url = "https://medium.com/better-programming/5-vs-code-extensions-thatll-change-your-dev-life-9786756a8121"; name = "5 VS Code Extensions That’ll Change Your Dev Life - Better Programming - Medium"; }
      #     { url = "https://medium.com/front-end-weekly/javascript-currying-vs-partial-application-4db5b2442be8"; name = "Javascript- Currying VS Partial Application - Frontend Weekly - Medium"; }
      #     { url = "https://medium.com/front-end-weekly/css-animation-events-in-javascript-d2bfe702636d"; name = "CSS Animation Events in JavaScript - Frontend Weekly - Medium"; }
      #     { url = "https://blog.bitsrc.io/understanding-memoization-in-javascript-to-improve-performance-2763ab107092"; name = "Understanding Memoization in JavaScript to Improve Performance"; }
      #     { url = "https://stackoverflow.com/questions/11744975/enabling-https-on-express-js"; name = "node.js - Enabling HTTPS on express.js - Stack Overflow"; }
      #     { url = "https://material.io/"; name = "Homepage - Material Design"; }
      #     { url = "https://getwaves.io/"; name = "svg waves"; }
      #     { url = "https://stripe.dev/react-stripe-elements/"; name = "Stripe React Elements"; }
      #     { url = "https://dev.to/daniel_werner/testing-typescript-with-mocha-and-chai-5cl8"; name = "testing in ts"; }
      #     { url = "https://firetechtutorsharriet.youcanbook.me/service/jsps/thanks.jsp?b=284d02e1-d834-4205-8a9d-3b60fe289e40&cal=9c542303-180c-4dc5-b942-63ee9bba0a87"; name = "Fire Tech Tutor Interviews with Harriet"; }
      #     { url = "https://github.com/microsoft/TypeScript/issues/32689"; name = "merge type ts"; }
      #     { url = "https://devdocs.io/cpp/"; name = "C++ documentation — DevDocs"; }
      #     { url = "https://neumorphism.io/"; name = "Neumorphism generator"; }
      #     { url = "https://blog.logrocket.com/how-to-build-a-server-rendered-react-app-with-next-express-d5a389e7ab2f/"; name = "next server"; }
      #     { url = "https://www.framer.com/motion/"; name = "Framer Motion"; }
      #     { url = "https://frontendmasters.com/courses/canvas-webgl/?utm_source=css-tricks&utm_medium=website&utm_campaign=css-tricks-tags-sidebar"; name = "creative coding"; }
      #     { url = "http://leksah.org/leksah_manual.pdf"; name = "Leksah"; }
      #     { url = "https://stackoverflow.com/questions/4037939/powershell-says-execution-of-scripts-is-disabled-on-this-system"; name = "exec policy win10"; }
      #     { url = "https://www.rexegg.com/regex-disambiguation.html"; name = "Advanced Regex "; }
      #     { url = "https://blog.usejournal.com/how-to-use-svg-in-react-native-e581eca59534"; name = "How to use SVG in React Native"; }
      #     { url = "https://scotch.io/"; name = "nice code site"; }
      #     { url = "https://stackoverflow.com/questions/48254562/python-equivalent-of-typescript-interface/48255117#48255117"; name = "Python interface "; }
      #     { url = "http://www.ita.uni-heidelberg.de/~dullemond/lectures/tensor/tensor.pdf"; name = "tensor"; }
      #     { url = "https://yoksel.github.io/svg-filters/#/"; name = "SVG Filters"; }
      #     { url = "https://www.npmjs.com/package/next-i18next"; name = "next-i18next - npm"; }
      #     { url = "https://tffk.itslearning.com/DashboardMenu.aspx?LocationType=Personal&DashboardType=MyPage"; name = "itslearning"; }
      #     { url = "https://www.colorsandfonts.com/"; name = "Colors and Fonts"; }
      #     { url = "https://undraw.co/illustrations"; name = "Illustrations "; }
      #     { url = "https://coolors.co/palettes/trending"; name = "Coolors"; }
      #     { url = "https://github.com/worawit/MS17-010/blob/83b3745050893fbc9d73fa61ff0b4aa427884a0e/shellcode/eternalblue_kshellcode_x64.asm"; name = "eternal blue"; }
      #     { url = "http://tylerneylon.com/a/learn-lua/"; name = "Learn Lua in 15 Minutes"; }
      #     { url = "https://web.dev/at-property/"; name = "@property"; }
      #     { url = "https://houdini.how/resources/"; name = "Houdini.how"; }
      #     { url = "https://neo4j.com/graph-algorithms-book/?utm_program=emea-prospecting&utm_source=google&utm_medium=cpc&utm_campaign=emea-pm-offer-content-ebook-graph-algorithms&utm_program=&utm_source=google&utm_medium=cpc&utm_campaign=&utm_adgroup=&gclid=Cj0KCQjwl9GCBhDvARIsAFunhsmOfvzCr0lD6R4ZCeqSycmenF-hx3PRWNMmTigZI9gUjIoJqHVzamkaAhXhEALw_wcB"; name = "O&#39;Reilly Graph Algorithms Book - Neo4j Graph Database Platform"; }
      #     { url = "http://localhost:3000/"; name = "React App"; }
      #     { url = "https://www.snoyman.com/base/"; name = "GHC/base/Cabal library versions"; }
      #     { url = "http://www.bbc.com/travel/story/20210117-stromatolites-the-earths-oldest-living-lifeforms"; name = "cool looking BBC site"; }
      #     { url = "https://github.com/lukakostic/ComputeShaderExamples/blob/master/ComputeShaderExamples/Particles/Snow/Snow.cs"; name = "ComputeShaderExamples/Snow.cs at master · lukakostic/ComputeShaderExamples"; }
      #     { url = "http://three-eyed-games.com/2018/05/03/gpu-ray-tracing-in-unity-part-1/"; name = "GPU RTX"; }
      #     { url = "https://www.domestika.org/en/courses/2078-art-deco-style-for-digital-illustration?gclid=CjwKCAjww-CGBhALEiwAQzWxOii_XUDa_kvDnjpP_smDxh29iM1CcFYcR-b0AeaGQM74sWp9FDdVDhoCFBwQAvD_BwE"; name = "Nice designe thing"; }
      #     { url = "https://github.com/wooorm/dictionaries"; name = "Auto complete"; }
      #     { url = "https://jutge.org/doc/haskell-cheat-sheet.pdf"; name = "haskell-cheat-sheet.pdf"; }
      #     { url = "https://www.hotjar.com/blog/psychographics-in-marketing/"; name = "Psychographic Marketing"; }
      #     { url = "https://www.toptal.com/designers/subtlepatterns/"; name = "Subtle Patterns"; }
      #     { url = "https://arunanshub.hashnode.dev/self-referential-structs-in-rust"; name = "Self Referential Structs in Rust (Part 1)"; }
      #     { url = "https://www.thecompleteuniversityguide.co.uk/student-advice/applying-to-uni/tips-for-writing-your-personal-statement"; name = "Tips for writing your personal statement"; }
      #   ];
      # }
      # {
      #   name = "Skole";
      #   bookmarks = [
      #     { url = "https://www.office.com/?auth=2"; name = "Office 365"; }
      #     { url = "https://heggen-vgs.inschool.visma.no/Login.jsp#/"; name = "Visma Bull Shit"; }
      #     { url = "https://www.geogebra.org/"; name = "Complex maths | geogebra"; }
      #     { url = "https://ptable.com/?lang=en#Properties"; name = "Periodic Table - Ptable"; }
      #     { url = "https://www.math.uci.edu/~xiangwen/pdf/LaTeX-Math-Symbols.pdf"; name = "LaTeX Math Symbols"; }
      #   ];
      # }
      # {
      #   name = "Random";
      #   bookmarks = [
      #     { url = "https://earth.nullschool.net/#current/space/surface/level/anim=off/overlay=aurora/orthographic=-337.25,56.21,439"; name = "aurora map"; }
      #     { url = "https://thenounproject.com/"; name = "Ungodly many icons"; }
      #     { url = "https://12ft.io/"; name = "12ft Ladder"; }
      #     { url = "https://saijogeorge.com/dummy-credit-card-generator/"; name = "Dummy Credit Card Generator 💳"; }
      #     { url = "https://www.remove.bg/"; name = "Remove Background from Image – remove.bg"; }
      #     { url = "https://www.lightningmaps.org/#m=oss;t=3;s=0;o=0;b=;ts=0;y=66.125;x=19.27;z=5;d=2;dl=2;dc=0;"; name = "Real Time Lightning Map :: LightningMaps.org"; }
      #   ];
      # }
      # {
      #   name = "CC1";
      #   bookmarks = [
      #     { url = "https://cdn.discordapp.com/attachments/866812331799740426/1015230245256826900/unknown.png"; name = "shift"; }
      #     { url = "https://cdn.discordapp.com/attachments/866812331799740426/1015230244975804457/unknown.png"; name = "numshift"; }
      #     { url = "https://cdn.discordapp.com/attachments/866812331799740426/1015230244514439209/unknown.png"; name = "character entry"; }
      #     { url = "https://cdn.discordapp.com/attachments/866812331799740426/1015230243595890739/unknown.png"; name = "shift num"; }
      #     { url = "https://launchpad.charachorder.com/#/"; name = "charachorder launchpad"; }
      #   ];
      # }
      # { url = "https://github.com/github/gitignore"; name = "git ignore"; }
      # { url = "https://beatsaver.com/"; name = "BeatSaver"; }
      # { url = "https://www.freethesaurus.com/"; name = "Tree dict"; }
      # ];

      # search.engines =
      #   {
      #     "Nix Packages" = {
      #       urls = [{
      #         template = "https://search.nixos.org/packages";
      #         params = [
      #           { name = "type"; value = "packages"; }
      #           { name = "query"; value = "{searchTerms}"; }
      #         ];
      #       }];

      #       icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      #       definedAliases = [ "@np" ];
      #     };

      #     "NixOS Wiki" = {
      #       urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
      #       iconUpdateURL = "https://nixos.wiki/favicon.png";
      #       updateInterval = 24 * 60 * 60 * 1000; # every day
      #       definedAliases = [ "@nw" ];
      #     };

      #     "Bing".metaData.hidden = true;
      #     "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
      #   };
    };
  };
}
