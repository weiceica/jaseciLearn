node person {
    has name;
    has birthday;
}

walker init {
    can date.quantize_to_year;
    can date.quantize_to_month;
    can date.quantize_to_week;

    person1 = spawn here ++> node::person(name="Josh", birthday="1995-05-20");

    birthyear = date.quantize_to_year(person1.birthday);
    birthmonth = date.quantize_to_month(person1.birthday);
    birthweek = date.quantize_to_week(person1.birthday);

    std.out("Date ", person1.birthday);
    std.out("Quantized date to year ", birthyear);
    std.out("Quantized date to month ", birthmonth);
    std.out("Quantized date to week ", birthweek);
}

node person {
    has name;
    has birthday;
}

walker init {
    can date.quantize_to_year;

    root {
        person1 = spawn here ++> node::person(name="Josh", birthday="1995-05-20");
        person2 = spawn here ++> node::person(name="Joe", birthday="1998-04-23");
        person3 = spawn here ++> node::person(name="Jack", birthday="1997-03-12");
        take -->;
    }

    person {
        birthyear = date.quantize_to_year(here.birthday);
        std.out(here.name," Birthdate Quantized to year ",birthyear);
        }
}

node person {
    has name;
    has byear;

    #this sets the birth year from the setter
    can date.quantize_to_year::visitor.year::>byear with setter entry;

    #this executes upon exit of the walker from node
    can std.out::byear," from ", visitor.info:: with exit;

}

walker init {

    #collect the current time
    has year=std.time_now();
    root {
        person1 = spawn here ++> node::person(name="Josh", byear="1992-01-01");
        take --> ;
    }

    person {
        spawn here walker::setter;
    }
}

walker setter {
    has year="1995-01-01";
    }