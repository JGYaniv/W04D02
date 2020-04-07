require_relative "employee"
class Manager < Employee
    attr_reader :employees
    # def initialize(salary,title,boss,name)
    # end

    def add_employees(emp_arr)
        @employees = emp_arr
    end

    def all_sub_emp
        sub_emps = []
        queue = employees.map(&:dup) #could just .dup work?
        until queue.empty?
            current_emp = queue.shift
            queue += current_emp.employees if current_emp.is_a?(Manager)
            sub_emps << current_emp
        end
        sub_emps
    end


    def bonus(multiplier)
        self.all_sub_emp.inject(0) {|acc, el| acc + el.salary } * multiplier
    end

end


ned = Manager.new(1000000,"Founder",nil, "Ned" )
darren = Manager.new(78000,"TA Manager",ned,"darren" )
david = Employee.new(10000,"TA",darren,"David")
shawna = Employee.new(12000, "TA", darren, "Shawna")

darren.add_employees([david,shawna])
ned.add_employees([darren])


p ned.bonus(5) # => 500_000
p darren.bonus(4) # => 88_000
p david.bonus(3) # => 30_000