# -*- coding: utf-8 -*-
require 'rexml/document'
require 'open-uri'
require 'optparse'

option={}
OptionParser.new do |opt|
  opt.on('-i', '--id=VALUE',   'AOJのコンテストID(必須)') {|v| option[:id] = v}
  opt.parse!(ARGV)

  if !option[:id]
    puts opt
    exit 1
  end
end

contestid=option[:id]
url="http://judge.u-aizu.ac.jp/onlinejudge/webservice/contest_status_log?id="+contestid
teamlistfile="teamlist.txt"

teams = File.open(teamlistfile).readlines
teams.each { |team|
  team.chomp!
}

puts "contest id:\t\t#{contestid}"
puts "onsite Team count:\t#{teams.size}"
puts "contest API url:\t#{url}\n\n"

xml = open(url)
doc = REXML::Document.new(xml)

allsubmit={}
onsitesubmit = {}
allac={}
onsiteac={}
allacteam={}
onsiteacteam={}
allFA={}
onsiteFA={}
doc.elements.each('contest_status/status') do |element|
  problem_id=element.elements['problem_id'].text
  user_id=element.elements['user_id'].text
  status_code =element.elements['status_code'].text
  next if status_code =="0"

  allsubmit[problem_id]=0 if !allsubmit.key?(problem_id)
  allsubmit[problem_id]=allsubmit[problem_id]+1

  if status_code =="4"
    allacteam[problem_id]=[] if !allacteam.key?(problem_id)
    allFA[problem_id]=user_id if !allFA.key?(problem_id)
    if !allacteam[problem_id].find{ |id| id==user_id}
      allacteam[problem_id].push(user_id)
      allac[problem_id]=0 if !allac.key?(problem_id)
      allac[problem_id]=allac[problem_id]+1
    end
  end

  if teams.find { |team| team == user_id}
    onsitesubmit[problem_id]=0 if !onsitesubmit.key?(problem_id)
    onsitesubmit[problem_id]=onsitesubmit[problem_id]+1

    if status_code =="4"
      onsiteacteam[problem_id]=[] if !onsiteacteam.key?(problem_id)
      onsiteFA[problem_id]=user_id if !onsiteFA.key?(problem_id)
      if !onsiteacteam[problem_id].find{ |id| id==user_id}
        onsiteacteam[problem_id].push(user_id)
        onsiteac[problem_id]=0 if !onsiteac.key?(problem_id)
        onsiteac[problem_id]=onsiteac[problem_id]+1
      end
    end
  end

end

puts "Onsite:" if onsitesubmit.size>0
onsitesubmit.to_a.sort.each do |prog|
  onsiteac[prog[0]]=0 if !onsiteac.key?(prog[0])
  puts "#{prog[0]}: #{onsiteac[prog[0]]}/#{prog[1]}  FA:#{onsiteFA[prog[0]]}"
end

puts "ALL:"
allsubmit.to_a.sort.each do |prog|
  allac[prog[0]]=0 if !allac.key?(prog[0])
  puts "#{prog[0]}: #{allac[prog[0]]}/#{prog[1]}  FA:#{allFA[prog[0]]}"
end
