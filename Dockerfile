FROM openjdk:8
#adding jar file from location
ADD jarstaging/com/valaxy/demo-workshop/2.1.2/demo-workshop-2.1.2.jar ttrend.jar
ENTRYPOINT ["java", "-jar", "ttrend.jar"]
