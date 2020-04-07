class Employee

    attr_reader :salary

    def initialize(salary,title,boss,name)
    @salary = salary
    @title = title 
    @boss = boss 
    @name = name
    end

    def bonus(multiplier)
        self.salary * multiplier
    end

end