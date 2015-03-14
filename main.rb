require 'rexml/document'
require 'open-uri'

contestid="RitsCamp15Day1"
url="http://judge.u-aizu.ac.jp/onlinejudge/webservice/contest_status_log?id="+contestid

teams = [
    "CALPIS",
    "yoposu",
    "too_Long",
    "nimoji",
    "Yanatsu",
    "Jorkers",
    "SKN",
    "mod_gzip",
    "kog",
    "Doubling",
    "WorkshopWitches",
    "AccountSheet",
    "omu_sawa_dan",
    "WJK",
    "UraKuni",
    "ODD",
]

puts "contest id: #{contestid}"
puts "contest API url: #{url}"
xml = open(url)
doc = REXML::Document.new(xml)

allsubmit={}
onsitesubmit = {}
allac={}
onsiteac={}
doc.elements.each('contest_status/status') do |element|
  problem_id=element.elements['problem_id'].text
  user_id=element.elements['user_id'].text

  allsubmit[problem_id]=0 if !allsubmit.key?(problem_id)
  allsubmit[problem_id]=allsubmit[problem_id]+1

  if element.elements['status_code'].text =="4"
    allac[problem_id]=0 if !allac.key?(problem_id)
    allac[problem_id]=allac[problem_id]+1
  end

  if teams.find { |team| team == user_id}
    onsitesubmit[problem_id]=0 if !onsitesubmit.key?(problem_id)
    onsitesubmit[problem_id]=onsitesubmit[problem_id]+1

    if element.elements['status_code'].text =="4"
     onsiteac[problem_id]=0 if !onsiteac.key?(problem_id)
     onsiteac[problem_id]=onsiteac[problem_id]+1
    end
  end

end

puts "ONsite:"
onsitesubmit.to_a.sort.each do |prog|
  onsiteac[prog[0]]=0 if !onsiteac.key?(prog[0])
  puts "#{prog[0]}: #{onsiteac[prog[0]]}/#{prog[1]}"
end

puts "ALL:"
allsubmit.to_a.sort.each do |prog|
  allsiteac[prog[0]]=0 if !allac.key?(prog[0])
  puts "#{prog[0]}: #{allac[prog[0]]}/#{prog[1]}"
end
