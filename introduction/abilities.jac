node city{
    has name;
    has tourists;

    can set_tourists{ #also can use "with activity"
        tourists = rand.integer(15,100);
        std.out("Setting number of tourists in", here.context.name,"city", "to",tourists);
    }
}

walker build_example{
    node1 = spawn here ++> node::city(name="c1");
    node2 = spawn node1 ++> node::city(name="c2");
    node3 = spawn node2 ++> node::city(name="c3");
    here ++> node2;
    node1 ++> node3;
}

walker init{

    root{
        spawn here walker::build_example;
        take-->;
    }

    city{
        here::set_tourists;
        take-->;
    }
}

node city{
    has name;
    has tourists;

    can set_tourists{ #also can use "with activity"
        if(here.tourists==null){
            tourists = rand.integer(15,100);
            std.out("Setting number of tourists in", here.context.name,"city", "to",tourists);
        }
    }

    can reset_tourists with traveller entry{
        here.tourists = here.tourists + visitor.tours;
        std.out("Total tourists in", here.context.name, "when traveller arrives:",here.tourists);
    }

}

walker build_example{
    node1 = spawn here ++> node::city(name="c1");
    node2 = spawn node1 ++> node::city(name="c2");
    node3 = spawn node2 ++> node::city(name="c3");
    here ++> node2;
    here ++> node3;
}

walker init{

    root{
        spawn here walker::build_example;
        take-->;
    }

    city{
        here::set_tourists;
        spawn here walker::traveller;
        take-->;
    }
}

walker traveller{
    has tours = 1;
}

node city{
    has name;
    has tourists;

    can set_tourists{ #also can use "with activity"
        if(here.tourists==null){
            tourists = rand.integer(15,100);
            std.out("Setting number of tourists in", here.context.name,"city", "to",tourists);
        }
    }
    can reset_tourists with traveler entry{
        here.tourists = here.tourists + visitor.tours;
        std.out("When traveler visits:",here.tourists, " tourists are in the city", here.context.name );
        visitor::print;
    }

}

walker build_example{
    node1 = spawn here ++> node::city(name="c1");
    node2 = spawn node1 ++> node::city(name="c2");
    node3 = spawn node2 ++> node::city(name="c3");
    here ++> node2;
    here ++> node3;
}

walker init{

    root{
        spawn here walker::build_example;
        take-->;
    }
    city{
        here::set_tourists;
        spawn here walker::traveler;
        take-->;
    }
}

walker traveler{
    has tours = 1;
    can print{
        std.out("Traveler enters the city");
    }
}

can reset_tourists_1 with traveler exit{
    here.tourists = here.tourists - visitor.tours;
    std.out("When traveler leaves:",here.tourists, "tourists are in the city", here.context.name);
}