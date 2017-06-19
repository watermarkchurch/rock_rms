module RockRMS
  class Client
    module Person
      def list_people(options={})
        res = get(people_path, options)
        RockRMS::Person.format(res)
      end

      def find_person(id)
        res = get(people_path(id))
        RockRMS::Person.format(res)
      end

      def find_person_by_email(email)
        res = get("People/GetByEmail/#{email}")
        RockRMS::Person.format(res)
      end

      def find_person_by_name(full_name)
        res = get("People/Search?name=#{full_name}&includeHtml=false&includeDetails=false&includeBusinesses=false&includeDeceased=false")
        RockRMS::Person.format(res)
      end

      def update_person(id, options = {})
        put(people_path(id), options)
      end

      private

      def people_path(id = nil)
        id ? "People/#{id}" : "People"
      end
    end
  end
end