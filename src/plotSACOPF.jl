
function PlotScenarios(Scen::Array{Scenario},fName::String)
    arrayScen=Array{Float64}(undef, 2*length(netload),length(Scen))
    for i=1:length(Scen)
        arrayScen[:,i]=vcat(
            [values(Scen[i].loadP[j]) for j=keys(netload)],
            [values(Scen[i].loadQ[j]) for j=keys(netload)]
        )
    end
    arrayScenP=sum(arrayScen[i,1:length(Scen)]
                   for i=1:length(netload))
    arrayScenQ=sum(arrayScen[i,1:length(Scen)]
                   for i=length(netload)+1:2*length(netload))
    plt=scatter(arrayScenP,arrayScenQ;lab="")
    savefig(plt,fName)
end

function PlotHeatScenarios(Scen::Array{Scenario},Weigth::Array{Float64},
                           fName::String)
    arrayScen=Array{Float64}(undef, 2*length(netload),length(Scen))
    for i=1:length(Scen)
        arrayScen[:,i]=vcat(
            [values(Scen[i].loadP[j]) for j=keys(netload)],
            [values(Scen[i].loadQ[j]) for j=keys(netload)]
        )
    end
    arrayScenP=sum(arrayScen[i,1:length(Scen)]
                   for i=1:length(netload))
    arrayScenQ=sum(arrayScen[i,1:length(Scen)]
                   for i=length(netload)+1:2*length(netload))
    plt=scatter(arrayScenP,arrayScenQ,marker_z=Weigth,
                 color=:heat,label="",legend=true;show=false)
    savefig(plt,fName)
end

function PlotSamplesPF(pass::Array{Scenario},fail::Array{Scenario},fName::String)
    passP=Array{Float64}[]
    passQ=Array{Float64}[]
    failP=Array{Float64}[]
    failQ=Array{Float64}[]
    if length(pass)!=0
        arrayPass=Array{Float64}(undef, 2*length(netload),length(pass))
        for i=1:length(pass)
            arrayPass[:,i]=vcat(
                [values(pass[i].loadP[j]) for j=keys(netload)],
                [values(pass[i].loadQ[j]) for j=keys(netload)]
            )
        end
        passP=sum(arrayPass[i,1:length(pass)]
                  for i=1:length(netload))
        passQ=sum(arrayPass[i,1:length(pass)]
                  for i=length(netload)+1:2*length(netload))
    end
    if length(fail)!=0
        arrayFail=Array{Float64}(undef, 2*length(netload),length(fail))
        for i=1:length(fail)
            arrayFail[:,i]=vcat(
                [values(fail[i].loadP[j]) for j=keys(netload)],
                [values(fail[i].loadQ[j]) for j=keys(netload)]
            )
        end
        failP=sum(arrayFail[i,1:length(fail)]
                  for i=1:length(netload))
        failQ=sum(arrayFail[i,1:length(fail)]
                  for i=length(netload)+1:2*length(netload))
    end
    plt2=scatter(passP,
                 passQ,
                 label="Pass";show=false,
                 color=:green)
    scatter!(plt2,failP,
             failQ,
             label="Fail";show=false,
             color=:red)
    savefig(plt2,fName)
end

function PlotSamplesPF(pass::Array{Scenario},fail::Array{Scenario},
                       clusters::Array{Scenario},fName::String)
    passP=Array{Float64}[]
    passQ=Array{Float64}[]
    failP=Array{Float64}[]
    failQ=Array{Float64}[]
    if length(pass)!=0
        arrayPass=Array{Float64}(undef, 2*length(netload),length(pass))
        for i=1:length(pass)
            arrayPass[:,i]=vcat(
                [values(pass[i].loadP[j]) for j=keys(netload)],
                [values(pass[i].loadQ[j]) for j=keys(netload)]
            )
        end
        passP=sum(arrayPass[i,1:length(pass)]
                  for i=1:length(netload))
        passQ=sum(arrayPass[i,1:length(pass)]
                  for i=length(netload)+1:2*length(netload))
    end
    if length(fail)!=0
        arrayFail=Array{Float64}(undef, 2*length(netload),length(fail))
        for i=1:length(fail)
            arrayFail[:,i]=vcat(
                [values(fail[i].loadP[j]) for j=keys(netload)],
                [values(fail[i].loadQ[j]) for j=keys(netload)]
            )
        end
        failP=sum(arrayFail[i,1:length(fail)]
                  for i=1:length(netload))
        failQ=sum(arrayFail[i,1:length(fail)]
                  for i=length(netload)+1:2*length(netload))
    end
    arrayClusters=Array{Float64}(undef, 2*length(netload),length(clusters))
    for i=1:length(clusters)
        arrayClusters[:,i]=vcat(
            [values(clusters[i].loadP[j]) for j=keys(netload)],
            [values(clusters[i].loadQ[j]) for j=keys(netload)]
        )
    end
    clustersP=sum(arrayClusters[i,1:length(clusters)]
                  for i=1:length(netload))
    clustersQ=sum(arrayClusters[i,1:length(clusters)]
                  for i=length(netload)+1:2*length(netload))
    plt2=scatter(passP,
                 passQ,
                 label="Pass";show=false,
                 color=:green)
    scatter!(plt2,failP,
             failQ,
             label="Fail";show=false,
             color=:red)
    scatter!(plt2,clustersP,clustersQ,label="Clusters",;show=false,color=:blue)
    savefig(plt2,fName)
end


function PlotFailedScen(fail::Array{Scenario},constrViolFail::Array{Set{String}},
                        fName::String)
    failP=Array{Float64}[]
    failQ=Array{Float64}[]
    if length(fail)!=0
        arrayFail=Array{Float64}(undef, 2*length(netload),length(fail))
        for i=1:length(fail)
            arrayFail[:,i]=vcat(
                [values(fail[i].loadP[j]) for j=keys(netload)],
                [values(fail[i].loadQ[j]) for j=keys(netload)]
            )
        end
        failP=sum(arrayFail[i,1:length(fail)]
                  for i=1:length(netload))
        failQ=sum(arrayFail[i,1:length(fail)]
                  for i=length(netload)+1:2*length(netload))
    end
    hashConstrViol=[hash(i) for i=constrViolFail]
    plt=scatter(failP,failQ,marker_z=hashConstrViol,
                 color=:rainbow,label="",legend=true;show=false)
    savefig(plt,fName)
end
