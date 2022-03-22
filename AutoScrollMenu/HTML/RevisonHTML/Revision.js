
var revisionPageData = {};
var containerView = document.getElementById('containerView');
var id = 0;

function revisionDetails(questions) {
    var output = containerView.innerHTML;
    if (questions.trending_search.length != 0) {
        for (let index = 0; index < questions.trending_search.length; index++) {
            if (questions.trending_search[index].type == "RevisionList") {
                output += '<button onclick="revisionTapped('+id+')" class="card container"><div style="overflow-x:scroll;overflow-y:hidden;font-size:15px;">' + decodeURIComponent(questions.trending_search[index].mathjax_question) + '</div></button>'
            } else {
                output += '<button onclick="revisionTapped('+id+')" class="gridButton"><div style="color:black;text-align:center;">' + decodeURIComponent(questions.trending_search[index].mathjax_question) + '</div></button>'
            }
            id += 1
        }
    }
    containerView.innerHTML = output;
}

function displayRevisions(questionsJsonEncodes) {
    try {
        var questionsJSON = JSON.parse(atob(questionsJsonEncodes));
        if (questionsJSON.revisionSection) {
            var revisions = questionsJSON.revisionSection
            if (revisions.trending_search) {
                if (revisions.trending_search.length > 0) {
                    revisionPageData["revisionSection"] = revisions
                    revisionDetails(revisions)
                }
            }
        }
    } catch(e) {}
}

function revisionTapped(questionIndex) {
    var revisionArray = [];
    revisionArray = revisionPageData.revisionSection.trending_search
    
    var question = revisionArray[questionIndex]
    var dataDictionary = {
        'question': question.mathjax_question,
        'qid': question.qid,
        'index': questionIndex
    }
    if ('webkit' in window)
        webkit.messageHandlers.revisionTapped.postMessage(dataDictionary);
}
