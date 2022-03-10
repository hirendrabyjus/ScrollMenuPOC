//
//  RevisonListViewModel.swift
//  AutoScrollMenu
//
//  Created by Hirendra Sharma on 09/03/22.
//


import Foundation
import UIKit

class RevisonListViewModel {
    
    var viewModel = ViewModel()
    var revisionLists: [Data] = [Data(mathjaxContent: "If the distribution of molecular speeds of gas is as per the figure shown below, then the ratio of the most probable, the average, and the root mean square speeds, respectively, is:<img alt=\"\" height=\"322\" src=\"https://df0b18phdhzpx.cloudfront.net/ckeditor_assets/pictures/1208279/original_28-10.png\" width=\"308\" data-src=\"\">", id: 0, type: "RevisionList"),Data(mathjaxContent: "A colourless aqueous solution contain nitrates of two metal, when it is added to an aqueous solution of <span id=\"MathJax-Element-1-Frame\" class=\"mjx-chtml\"><span id=\"MJXc-Node-13636\" class=\"mjx-math\"><span id=\"MJXc-Node-13637\" class=\"mjx-mrow\"><span id=\"MJXc-Node-13638\" class=\"mjx-mi\"><span class=\"mjx-char MJXc-TeX-math-I\" style=\"padding-top: 0.446em; padding-bottom: 0.298em; padding-right: 0.085em;\">N</span></span><span id=\"MJXc-Node-13639\" class=\"mjx-mi\"><span class=\"mjx-char MJXc-TeX-math-I\" style=\"padding-top: 0.225em; padding-bottom: 0.298em;\">a</span></span><span id=\"MJXc-Node-13640\" class=\"mjx-mi\"><span class=\"mjx-char MJXc-TeX-math-I\" style=\"padding-top: 0.519em; padding-bottom: 0.298em; padding-right: 0.045em;\">C</span></span><span id=\"MJXc-Node-13641\" class=\"mjx-mi\"><span class=\"mjx-char MJXc-TeX-math-I\" style=\"padding-top: 0.446em; padding-bottom: 0.298em;\">l</span></span></span></span></span>, a white precipitate ws formed. This precipitate was found to be partially soluble in hot water to give a residue <span id=\"MathJax-Element-2-Frame\" class=\"mjx-chtml\"><span id=\"MJXc-Node-13642\" class=\"mjx-math\"><span id=\"MJXc-Node-13643\" class=\"mjx-mrow\"><span id=\"MJXc-Node-13644\" class=\"mjx-mi\"><span class=\"mjx-char MJXc-TeX-math-I\" style=\"padding-top: 0.446em; padding-bottom: 0.298em; padding-right: 0.109em;\">P</span></span></span></span></span> and a solution <span id=\"MathJax-Element-3-Frame\" class=\"mjx-chtml\"><span id=\"MJXc-Node-13645\" class=\"mjx-math\"><span id=\"MJXc-Node-13646\" class=\"mjx-mrow\"><span id=\"MJXc-Node-13647\" class=\"mjx-mi\"><span class=\"mjx-char MJXc-TeX-math-I\" style=\"padding-top: 0.519em; padding-bottom: 0.446em;\">Q</span></span></span></span></span>. The residue <span id=\"MathJax-Element-4-Frame\" class=\"mjx-chtml\"><span id=\"MJXc-Node-13648\" class=\"mjx-math\"><span id=\"MJXc-Node-13649\" class=\"mjx-mrow\"><span id=\"MJXc-Node-13650\" class=\"mjx-mi\"><span class=\"mjx-char MJXc-TeX-math-I\" style=\"padding-top: 0.446em; padding-bottom: 0.298em; padding-right: 0.109em;\">P</span></span></span></span></span> was solublein aq. in <span id=\"MathJax-Element-5-Frame\" class=\"mjx-chtml\"><span id=\"MJXc-Node-13651\" class=\"mjx-math\"><span id=\"MJXc-Node-13652\" class=\"mjx-mrow\"><span id=\"MJXc-Node-13653\" class=\"mjx-mi\"><span class=\"mjx-char MJXc-TeX-math-I\" style=\"padding-top: 0.446em; padding-bottom: 0.298em; padding-right: 0.085em;\">N</span></span><span id=\"MJXc-Node-13654\" class=\"mjx-texatom\"><span id=\"MJXc-Node-13655\" class=\"mjx-mrow\"><span id=\"MJXc-Node-13656\" class=\"mjx-msubsup\"><span class=\"mjx-base\" style=\"margin-right: -0.057em;\"><span id=\"MJXc-Node-13657\" class=\"mjx-texatom\"><span id=\"MJXc-Node-13658\" class=\"mjx-mrow\"><span id=\"MJXc-Node-13659\" class=\"mjx-mi\"><span class=\"mjx-char MJXc-TeX-math-I\" style=\"padding-top: 0.446em; padding-bottom: 0.298em; padding-right: 0.057em;\">H</span></span></span></span></span><span class=\"mjx-sub\" style=\"font-size: 70.7%; vertical-align: -0.212em; padding-right: 0.071em;\"><span id=\"MJXc-Node-13660\" class=\"mjx-texatom\" style=\"\"><span id=\"MJXc-Node-13661\" class=\"mjx-mrow\"><span id=\"MJXc-Node-13662\" class=\"mjx-mn\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.372em; padding-bottom: 0.372em;\">3</span></span></span></span></span></span></span></span></span></span></span> and also in excess sodium thiosulfate. The hot solution <span id=\"MathJax-Element-6-Frame\" class=\"mjx-chtml\"><span id=\"MJXc-Node-13663\" class=\"mjx-math\"><span id=\"MJXc-Node-13664\" class=\"mjx-mrow\"><span id=\"MJXc-Node-13665\" class=\"mjx-mi\"><span class=\"mjx-char MJXc-TeX-math-I\" style=\"padding-top: 0.519em; padding-bottom: 0.446em;\">Q</span></span></span></span></span> gave a yellow precipitate with <span id=\"MathJax-Element-7-Frame\" class=\"mjx-chtml\"><span id=\"MJXc-Node-13666\" class=\"mjx-math\"><span id=\"MJXc-Node-13667\" class=\"mjx-mrow\"><span id=\"MJXc-Node-13668\" class=\"mjx-mi\"><span class=\"mjx-char MJXc-TeX-math-I\" style=\"padding-top: 0.446em; padding-bottom: 0.298em; padding-right: 0.04em;\">K</span></span><span id=\"MJXc-Node-13669\" class=\"mjx-mi\"><span class=\"mjx-char MJXc-TeX-math-I\" style=\"padding-top: 0.446em; padding-bottom: 0.298em; padding-right: 0.064em;\">I</span></span></span></span></span>.  The metals <span id=\"MathJax-Element-8-Frame\" class=\"mjx-chtml\"><span id=\"MJXc-Node-13670\" class=\"mjx-math\"><span id=\"MJXc-Node-13671\" class=\"mjx-mrow\"><span id=\"MJXc-Node-13672\" class=\"mjx-mi\"><span class=\"mjx-char MJXc-TeX-math-I\" style=\"padding-top: 0.446em; padding-bottom: 0.298em; padding-right: 0.024em;\">X</span></span></span></span></span> and <span id=\"MathJax-Element-9-Frame\" class=\"mjx-chtml\"><span id=\"MJXc-Node-13673\" class=\"mjx-math\"><span id=\"MJXc-Node-13674\" class=\"mjx-mrow\"><span id=\"MJXc-Node-13675\" class=\"mjx-mi\"><span class=\"mjx-char MJXc-TeX-math-I\" style=\"padding-top: 0.446em; padding-bottom: 0.298em; padding-right: 0.182em;\">Y</span></span></span></span></span>, respectively, are:\n", id: 1, type: "RevisionList"),Data(mathjaxContent: "If the distribution of molecular speeds of gas is as per the figure shown below, then the ratio of the most probable, the average, and the root mean square speeds, respectively, is:<img alt=\"\" height=\"322\" src=\"https://df0b18phdhzpx.cloudfront.net/ckeditor_assets/pictures/1208279/original_28-10.png\" width=\"308\" data-src=\"\">",id: 2, type: "RevisionList"),Data(mathjaxContent: "If the distribution of molecular speeds of gas is as per the figure shown below, then the ratio of the most probable, the average, and the root mean square speeds, respectively, is:<img alt=\"\" height=\"322\" src=\"https://df0b18phdhzpx.cloudfront.net/ckeditor_assets/pictures/1208279/original_28-10.png\" width=\"308\" data-src=\"\">", id: 3, type: "RevisionList"),Data(mathjaxContent: "If the distribution of molecular speeds of gas is as per the figure shown below, then the ratio of the most probable, the average, and the root mean square speeds, respectively, is:<img alt=\"\" height=\"322\" src=\"https://df0b18phdhzpx.cloudfront.net/ckeditor_assets/pictures/1208279/original_28-10.png\" width=\"308\" data-src=\"\">", id: 4, type: "RevisionList"),Data(mathjaxContent: "If the distribution of molecular speeds of gas is as per the figure shown below, then the ratio of the most probable, the average, and the root mean square speeds, respectively, is:<img alt=\"\" height=\"322\" src=\"https://df0b18phdhzpx.cloudfront.net/ckeditor_assets/pictures/1208279/original_28-10.png\" width=\"308\" data-src=\"\">", id: 5, type: "RevisionList"),Data(mathjaxContent: "If the distribution of molecular speeds of gas is as per the figure shown below, then the ratio of the most probable, the average, and the root mean square speeds, respectively, is:<img alt=\"\" height=\"322\" src=\"https://df0b18phdhzpx.cloudfront.net/ckeditor_assets/pictures/1208279/original_28-10.png\" width=\"308\" data-src=\"\">",id: 6, type: "RevisionList"),Data(mathjaxContent: "If the distribution of molecular speeds of gas is as per the figure shown below, then the ratio of the most probable, the average, and the root mean square speeds, respectively, is:<img alt=\"\" height=\"322\" src=\"https://df0b18phdhzpx.cloudfront.net/ckeditor_assets/pictures/1208279/original_28-10.png\" width=\"308\" data-src=\"\">", id: 7, type: "RevisionList"),Data(mathjaxContent: "If the distribution of molecular speeds of gas is as per the figure shown below, then the ratio of the most probable, the average, and the root mean square speeds, respectively, is:<img alt=\"\" height=\"322\" src=\"https://df0b18phdhzpx.cloudfront.net/ckeditor_assets/pictures/1208279/original_28-10.png\" width=\"308\" data-src=\"\">", id: 8, type: "RevisionList"),Data(mathjaxContent: "If the distribution of molecular speeds of gas is as per the figure shown below, then the ratio of the most probable, the average, and the root mean square speeds, respectively, is:<img alt=\"\" height=\"322\" src=\"https://df0b18phdhzpx.cloudfront.net/ckeditor_assets/pictures/1208279/original_28-10.png\" width=\"308\" data-src=\"\">",id: 9, type: "RevisionList"),Data(mathjaxContent: "If the distribution of molecular speeds of gas is as per the figure shown below, then the ratio of the most probable, the average, and the root mean square speeds, respectively, is:<img alt=\"\" height=\"322\" src=\"https://df0b18phdhzpx.cloudfront.net/ckeditor_assets/pictures/1208279/original_28-10.png\" width=\"308\" data-src=\"\">",id: 10, type: "RevisionList")]
    
}
