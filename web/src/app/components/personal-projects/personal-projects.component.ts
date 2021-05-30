import { Component, OnInit } from '@angular/core'
import { Location } from 'src/app/models/location'
import { NavigationService } from 'src/app/services/navigation/navigation.service'

@Component({
    templateUrl: './personal-projects.component.html',
    styleUrls: ['./personal-projects.component.scss'],
})
export class PersonalProjectsComponent implements OnInit {
    constructor(private navigationService: NavigationService) {}

    ngOnInit(): void {
        this.navigationService.updateLocation(Location.PERSONAL_PROJECTS)
    }
}
