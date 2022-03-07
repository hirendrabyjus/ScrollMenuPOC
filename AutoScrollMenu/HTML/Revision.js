var revisions = {
    "trending_search": [
        {
            "book_name": "",
            "chapter_name": "",
            "grade": "Standard XII",
            "mathjax_question": "<p>What is actually GDP ?</p>",
            "qid": 672857,
            "question": "<p>What is actually GDP ?</p>",
            "raw_grade": 12,
            "subject": "Biology"
        },
        {
            "book_name": "",
            "chapter_name": "",
            "grade": "Standard XII",
            "mathjax_question": "<p>Integrate xtanx</p>",
            "qid": 692296,
            "question": "<p>Integrate xtanx</p>",
            "raw_grade": 12,
            "subject": "Mathematics"
        },
        {
            "book_name": "",
            "chapter_name": "",
            "grade": "Standard XII",
            "mathjax_question": "Define budget line.",
            "qid": 99995880771,
            "question": "Define budget line.",
            "raw_grade": 12,
            "subject": "Economics"
        },
        {
            "book_name": "",
            "chapter_name": "",
            "grade": "Standard XII",
            "mathjax_question": "Define Central Bank",
            "qid": 99994839789,
            "question": "Define Central Bank",
            "raw_grade": 12,
            "subject": "Business and Commercial Knowledge"
        },
        {
            "book_name": "",
            "chapter_name": "",
            "grade": "Standard XII",
            "mathjax_question": "What is Money Bill?",
            "qid": 99996029124,
            "question": "What is Money Bill?",
            "raw_grade": 12,
            "subject": "Civics"
        }
    ],
    "FlowDocId": "61d4049165c63b22042a416b",
    "suggestions": [
        {
            "book_name": "",
            "chapter_name": "",
            "grade": "Standard XII",
            "mathjax_question": "<p>What is actually GDP ?</p>",
            "qid": 672857,
            "question": "<p>What is actually GDP ?</p>",
            "raw_grade": 12,
            "subject": "Biology"
        },
        {
            "book_name": "",
            "chapter_name": "",
            "grade": "Standard XII",
            "mathjax_question": "<p>Integrate xtanx</p>",
            "qid": 692296,
            "question": "<p>Integrate xtanx</p>",
            "raw_grade": 12,
            "subject": "Mathematics"
        },
        {
            "book_name": "",
            "chapter_name": "",
            "grade": "Standard XII",
            "mathjax_question": "Define budget line.",
            "qid": 99995880771,
            "question": "Define budget line.",
            "raw_grade": 12,
            "subject": "Economics"
        },
        {
            "book_name": "",
            "chapter_name": "",
            "grade": "Standard XII",
            "mathjax_question": "Define Central Bank",
            "qid": 99994839789,
            "question": "Define Central Bank",
            "raw_grade": 12,
            "subject": "Business and Commercial Knowledge"
        },
        {
            "book_name": "",
            "chapter_name": "",
            "grade": "Standard XII",
            "mathjax_question": "What is Money Bill?",
            "qid": 99996029124,
            "question": "What is Money Bill?",
            "raw_grade": 12,
            "subject": "Civics"
        }
    ],
    "status": {
        "code": 200,
        "isError": false
    }
}

var revisionPageData = {};
var containerView = document.getElementById('containerView');
var id = 0;

function revisionDetails(questions) {
    var output = containerView.innerHTML;
    if (questions.trending_search.length != 0) {
        for (let index = 0; index < questions.trending_search.length; index++) {
            output += '<button onclick="revisionTapped('+id+')" class="gridButton"><div style="color:black;text-align:center;">' + decodeURIComponent(questions.trending_search[index].mathjax_question) + '</div></button>'
            id += 1
            console.log(id)
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
        'question': question.question,
        'qid': question.qid,
        'index': questionIndex
    }
    if ('webkit' in window)
        webkit.messageHandlers.revisionTapped.postMessage(dataDictionary);
}
