hds = newDS()
for line in io.lines("/var/powerdns_chroot/forward.txt") do
    hds:add{line}
end

function preresolve(dq)
   if hds:check(dq.qname) then
       if dq.qtype == pdns.A then
           pdnslog(log_entry, pdns.loglevels.Info)
           dq:addAnswer(pdns.A, '145.237.235.240')
           return true;
        else
           pdnslog(log_entry, pdns.loglevels.Info)
           dq.appliedPolicy.policyKind = pdns.policykinds.NODATA
       end
   end

  return false;
end
