norm.test <- function(x, breaks = 20, alpha = 0.05,
plot = TRUE){
if(plot == TRUE)
{#����ͼ�ν��棨��ͼ��Ϊһ��ͼ��
opar <- par(no.readonly = TRUE)
layout(matrix(c(1,1,2,3),2,2,byrow = TRUE),
width = c(2,2),heights = c(2,2))
#����ֱ��ͼ
hist(x, freq = FALSE, breaks = seq(min(x),
max(x), length = breaks), main = 'x��ֱ��ͼ',
ylab = '���ܶ�ֵ')
#���Ӻ��ܶ�ͼ
lines(density(x), col = 'red', lty = 1, lwd = 2)
#������̬�ֲ�ͼ
x <- x[order(x)]
lines(x, dnorm(x, mean(x), sd(x)),
col = 'blue', lty = 2, lwd = 2.5)
#����ͼ��
legend('topright',
legend = c('���ܶ�����','��̬�ֲ�����'),
col = c('red','blue'), lty = c(1,2),
lwd = c(2,2.5), bty = 'n')
#����Q-Qͼ
qqnorm(x, xlab = 'ʵ�ʷֲ�', ylab = '��̬�ֲ�',
main = 'x��Q-Qͼ', col = 'blue')
qqline(x)
#����P-Pͼ
P <- pnorm(x, mean(x), sd(x))
cdf <- 0
for(i in 1:length(x)){cdf[i] <- sum(x <= x[i])/length(x)}
plot(cdf, P, xlab = 'ʵ�ʷֲ�', ylab = '��̬�ֲ�',
main = 'x��P-Pͼ', xlim = c(0,1),
ylim = c(0,1), col = 'blue')
abline(a = 0, b = 1)
par(opar)
}
#������shapiro����
if (length(x) <= 5000) {
shapiro <- shapiro.test(x)
if(shapiro$p.value > alpha)
print(paste('�������Ϊ��', 'x������̬�ֲ���',
'Pֵ =',round(shapiro$p.value,5), '> 0.05'))
else
print(paste('�������Ϊ��', 'x��������̬�ֲ���',
'Pֵ =',round(shapiro$p.value,5), '<= 0.05'))
shapiro
}
else {
ks <- ks.test(x,'pnorm')
if(ks$p.value > alpha)
print(paste('�������Ϊ��', 'x������̬�ֲ���',
'Pֵ =',round(ks$p.value,5), '> 0.05'))
else
print(paste('�������Ϊ��', 'x��������̬�ֲ���',
'Pֵ =',round(ks$p.value,5), '<= 0.05'))
ks
}
}