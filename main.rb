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

p url
xml = open(url)
doc = REXML::Document.new(xml)

allsubmit={}
onsitesubmit = {}
allac={}
onsiteac={}
doc.elements.each('contest_status/status') do |element|
  problem_id=element.elements['problem_id'].text
  user_id=element.elements['user_id'].text

  if allsubmit.key?(problem_id) then
    allsubmit[problem_id]=allsubmit[problem_id]+1
  else
    allsubmit[problem_id]=1
  end
  if element.elements['status_code'].text =="4"
    if allac.key?(problem_id) then
      allac[problem_id]=allac[problem_id]+1
    else
      allac[problem_id]=1
    end
  end

  if teams.find { |team| team == user_id}
    if onsitesubmit.key?(problem_id) then
      onsitesubmit[problem_id]=onsitesubmit[problem_id]+1
    else
      onsitesubmit[problem_id]=1
    end

    if element.elements['status_code'].text =="4"
      if onsiteac.key?(problem_id) then
        onsiteac[problem_id]=onsiteac[problem_id]+1
      else
        onsiteac[problem_id]=1
      end
    end
  end

end

puts "ONsite:"
onsitesubmit.to_a.sort.each do |prog|
  puts prog[0]+ ": "+onsiteac[prog[0]].to_s+ "/"+prog[1].to_s
end
puts "ALL:"
allsubmit.to_a.sort.each do |prog|
  puts prog[0]+ ": "+allac[prog[0]].to_s+ "/"+prog[1].to_s
end
