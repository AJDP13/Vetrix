import {expect, test, beforeAll, afterAll} from "vitest";
import PrescriptionService from "../../src/modules/prescriptions/prescription.service";
import {CreatePrescriptionDto} from "../../src/modules/prescriptions/prescription.types";
import Pet from "../../src/modules/pets/pet.model";
import Prescription from "../../src/modules/prescriptions/prescription.model";
import {buildPetResponse} from "../../src/modules/pets/pet.mapper";
import {setupAssociations} from "../../src/database/associations";
import Client from "../../src/modules/clients/client.model";
import ClientService from "../../src/modules/clients/client.service";
import {ClientResponse} from "../../src/modules/clients/client.types";
import PetService from "../../src/modules/pets/pet.service";
import {PetResponse} from "../../src/modules/pets/pet.types";

const prescriptionService = new PrescriptionService();

setupAssociations();

let test_owner: ClientResponse;
let test_pet: PetResponse;
let test_prescription_data: CreatePrescriptionDto;

beforeAll(async () => {
    test_owner = await new ClientService().createClient({
        first_name: "arun",
        last_name: "dutta",
        email: `arun-${Date.now()}@aerotrixlabs.com`,
        phone: "07817202247"
    })
    test_pet = await new PetService().createPet({
        name: "Test",
        dob: new Date(),
        owner_id: test_owner.id
    })

    test_prescription_data = {
        pet_id: test_pet.id,
        prescribed_at: new Date(),
        expires_at: new Date(),
        max_repeats: 4,
        repeat_interval_days: 30,
        prescribed_by: "Arun DP",
        prescribing_practice: "Arun Vets",
        notes: "Test Notes about drugs here"
    };
});



test("Create new prescription in DB", async () => {

    const resp = await prescriptionService.createPrescription(test_prescription_data);
    await Prescription.destroy({
        where:{
            id: resp.id
        },
        force:true
    });

    const {
        prescribed_at,
        expires_at,
        pet_id,
        ...expected_outcome
    } = test_prescription_data;

    expect(resp).toMatchObject(expected_outcome);

    expect(resp).toMatchObject(expected_outcome)
    expect(resp.id).toEqual(expect.any(String));
    expect(resp.pet).toMatchObject(test_pet);
    expect(resp.prescribed_at).toBeInstanceOf(Date);
    expect(resp.expires_at).toBeInstanceOf(Date);
})

//Destroy created pet
afterAll(async()=>{
    if(!test_pet){
        console.log("NO TEST PET FOUND");
        return;
    }
    await Pet.destroy({
        where:{
            id: test_pet.id
        },
        force:true
    });

    await Client.destroy({
        where:{
            id: test_owner.id
        },
        force:true
    })
})