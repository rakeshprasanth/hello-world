function [n,c]=nullColumnBasis(A)
order=size(A)
n=order(1,2)
m=order(1,1)
if m<n
  min=m
  minrows=1
else
  min=n
  mincols=1
endif

M=[transpose(A),eye(n)]
for i=1:min
  if M(i,i)==0
    flag=1
    for j=i+1:n
      if M(j,i)!=0
        M([i j],:)=M([j i],:)
        swap=j
        flag=0
        break
      endif
    endfor
  endif
  if M(i,i)!=0
    M(i,:)=M(i,:)/M(i,i)
  endif
  for j=i+1:n
    M(j,:)=M(j,:)-M(j,i)*M(i,:)
  endfor
endfor
basis=0
for i=min:-1:1
  if M(i,i)==0
    basis=basis+1
    continue
  endif
  for j=i-1:-1:1
    M(j,:)=M(j,:)-M(j,i)*M(i,:)
  endfor
endfor
n_temp=M((min+1-basis):n,(m+1):(m+n))
c_temp=M(1:(min-basis),1:m)
n=transpose(n_temp)
c=transpose(c_temp)
