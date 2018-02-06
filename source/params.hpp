class Params {
    class DeathPenalty {
        title = "CP death penalty";
        values[] = {1,2,3,4,5,6,7,8,9,10,0};
        texts[] = {"1","2","3","4","5","6","7","8","9","10","No penalty"};
        default = 1;
    };
    class Debug {
        title = "set debug";
        values[] = {0, 1};
        texts[]  = {"false", "true"};
        default = 0;
    };
    class start_CP {
        title = "start CP";
        values[] = {5 ,10, 20, 40, 60, 80, 100};
        texts[]  = {"5", "10", "20", "40", "60", "80", "100"};
        default = 60;
    };
    class zones_number {
        title = "Number of Zones";
        values[] = {1, 2, 3, 5, 7, 10, 15};
        texts[]  = {"1", "2", "3", "5", "7", "10", "15"};
        default = 5;
    };
}