import { Component, OnInit } from '@angular/core'
import { Location } from 'src/app/models/location'
import { NavigationService } from 'src/app/services/navigation/navigation.service'

@Component({
    styleUrls: ['./skills-and-achievements.component.scss'],
    templateUrl: './skills-and-achievements.component.html',
})
export class SkillsAndAchievementsComponent implements OnInit {
    constructor(private navigationService: NavigationService) {}

    ngOnInit(): void {
        this.navigationService.currentLocation$.next(
            Location.SKILLS_AND_ACHIEVEMENTS
        )
    }
}
