require 'nmap'
require 'net/http'
require 'json'

module Nmap
    module CPE
        def each_cpe
            return enum_for(__method__) unless block_given?

            @node.xpath('cpe').each do |cpe|
                yield URL.parse(cpe.inner_text)
            end
        end
        
    end
    
end

module PortScan
    class CveSearch
        def http_get_cve_for_cpe(cpe)
            cvesearch_api_domain = PortScan.configuration.cvesearch_api_domain
            return Net::HTTP.get(cvesearch_api_domain, 'api/cvefor' + cpe.to_s)
        end
        def get_cve_edb_url(cve)
            return unless cve['map_cve_exploitdb']
            edb_script = cve['map_cve_exploitdb']['exploitdbscripts']
            if edb_script.include? "http"
                edb_script.sub!('http:', 'https:')
                return edb_script
            elsif edb_script.include? "/"
                gitedb_url = PortScan.configuration.gitedb_url
                return gitedb_url + edb_script
            else
                edb_url = PortScan.configuration.edb_url
                edb_id = cve['map_cve_exploitdb']['exploitdbid']
                return edb_url + edb_id
            end
            
        end

        def get_cve_msf_url(cve)
            return unless cve['map_cve_msf']
            gitmsf_url = PortScan.configuration.gitmsf_url
            msf_script_file = cve['map_cve_msf']['msf_script_file']
            msf_script_file.sub!('metasploit-framework/','')
            return gitmsf_url + msf_script_file
        end
        

        def get_cves_from_cpe(c)
            return unless c.to_s != "cpe:/o:microsoft:windows"
            res = JSON.parse(http_get_cve_for_cpe(c))
            cves = []
            res.each_with_index do |cve, i|
                cves[i] = {
                    :id => cve['id'],
                    :access => cve['access'],
                    :impact => cve['impact'],
                    :edb => get_cve_edb_url(cve),
                    :msf => get_cve_msf_url(cve),
                    :idurl => PortScan.configuration.cve_id_url + cve['id'],
                }
            end
            return cves
        end
        
        def get_cpes_with_cves_from_port(port)
            cpes = {}
            port.service.cpe.each do |c|
                cpe = c.to_s.to_sym
                cpes[cpe] = get_cves_from_cpe(c)
            end
            return cpes
        end
        

        def get_cpes_with_cves_from_host(host)
            return unless host.os
            cpes = {}
            host.os.classes.each do |o|
                o.cpe.each do |c|
                    cpe = c.to_s.to_sym
                    cpe[cpe] = get_cves_from_cpe(c)
                end
            end
            return cpes
        end
        

        def scan(filename)
            hosts = []
            Nmap::XML.new(filename) do |x|
                x.each_host do |h|
                    host_hash = {
                        :mac => h.mac,
                        :ip => h.address,
                        :status => h.status,
                        :vendor => h.vendor,
                        :hostnames => h.hostnames,
                        :cpes => get_cpes_with_cves_from_host(h),
                        :ports => [], 
                    }
                    h.ports.each do |port|
                        port_hash = {
                            :protocol => port.protocol,
                            :state => port.state,
                            :product => port.service.product,
                            :version => port.service.version,
                            :extra_info => port.service.extra_info,
                            :reason => port.reason,
                            :name => port.service.name,
                            :port => port.number,
                            :cpes => get_cpes_with_cves_from_port(port),
                        }
                        host_hash[:ports].push(port_hash)
                    end
                    hosts.push(host_hash)
                end
            end
           return hosts
        end
    end 



    class Portscan
        def sudo_scan(opts)
            Nmap::Program.sudo_scan do |s|
                s.service_scan = opts['service_scan']
                s.all_ports = opts['all_ports']
                s.syn_discovery = opts['syn_discovery']
                s.output_all = opts['output_all']
                s.targets = opts['targets']
            end
        end
        
        def scan(opts)
            Nmap::Program.sudo_scan do |s|
                s.service_scan = opts['service_scan']
                s.all_ports = opts['all_ports']
                s.syn_discovery = opts['syn_discovery']
                s.output_all = opts['output_all']
                s.targets = opts['targets']
            end
        end
    end
end