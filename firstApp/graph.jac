node state {
    has title;
    has message;
    has prompts;
}


edge transition {
    has intent;
}

graph main_graph {
    has anchor main_root;

    spawn {

        main_root = spawn node::state(
        title = "Welcome",
        message = "Welcome to Jaseci Dojo, how can i help?",
        prompts = ["class","times","prices","quit"]
    );

    prices = spawn main_root -[transition(intent="prices")] -> node::state(
        title = "prices",
        message = "Prices Vary based on age",
        prompts = ["12 and younger", "18 and younger" ,"Older than 18", "quit"]
    );

    prices_12 = spawn prices -[transition(intent="12 and younger")] -> node::state(
        title = "prices<12",
        message = "Childer under 12 pay $100 per month",
        prompts = ["more prices", "quit"]
    );
     prices_12 -[transition(intent="more prices")] -> prices;

     prices_18 = spawn prices -[transition(intent="18 and younger")] -> node::state(
        title = "prices<18",
        message = "Childer under 18 pay $110 per month",
        prompts = ["more prices", "quit"]
    );

    prices_18 -[transition(intent="more prices")] -> prices;

     pricesabove18 = spawn prices -[transition(intent="Older than 18")] -> node::state(
        title = "pricesadults",
        message = "Adults over 18 pay $150 per month",
        prompts = ["more prices","quit"]
    );
     pricesabove18 -[transition(intent="more prices")] -> prices;


    class = spawn main_root -[transition(intent="class")]-> node::state(
        title = "class",
        message = "There are 3 classes per week and you are required to attend a minimum of 2.",
        prompts = ["time","days","prices","quit"]

    );



    time = spawn class -[transition(intent="time")]-> node::state(
        title = "time",
        message = "Classes are from 3 pm to 4 pm",
        prompts = ["other times","days","quit"]
    );

    main_root -[transition(intent="times")] -> time;

    other_time = spawn time -[transition(intent="other times")]-> node::state(
        title = "Other times",
        message ="The clases are at 4 pm to 5 pm but you need at least 4 other students to start",
        prompts = ['days',"quit"]
    );




     days = spawn time -[transition(intent="days")]-> node::state(
        title = "days",
        message ="The classes are on Monday ,Wednesday , Friday",
        prompts = ['time',"quit"]
    );


     other_time - [transition(intent="days")] -> days ;
     days - [transition(intent="time")] -> time ;

    }
}