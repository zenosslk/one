# -------------------------------------------------------------------------- #
# Copyright 2002-2014, OpenNebula Project (OpenNebula.org), C12G Labs        #
#                                                                            #
# Licensed under the Apache License, Version 2.0 (the "License"); you may    #
# not use this file except in compliance with the License. You may obtain    #
# a copy of the License at                                                   #
#                                                                            #
# http://www.apache.org/licenses/LICENSE-2.0                                 #
#                                                                            #
# Unless required by applicable law or agreed to in writing, software        #
# distributed under the License is distributed on an "AS IS" BASIS,          #
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   #
# See the License for the specific language governing permissions and        #
# limitations under the License.                                             #
#--------------------------------------------------------------------------- #

require 'nokogiri'

module Migrator
    def db_version
        "4.6.0"
    end

    def one_version
        "OpenNebula 4.6.0"
    end

    def up
        last_oid = -1

        @db.fetch("SELECT last_oid FROM pool_control WHERE tablename='acl'") do |row|
            last_oid = row[:last_oid].to_i
        end

        # * ZONE/* USE *
        @db.run "INSERT INTO acl VALUES(#{last_oid+1},17179869184,140754668224512,1,17179869184);"

        @db.run "REPLACE INTO pool_control VALUES('acl', #{last_oid+1});"

        return true
    end
end